module GirFFI
  # Implements the creation of a Ruby function definition out of a GIR
  # IFunctionInfo.
  class FunctionDefinitionBuilder
    ArgData = Struct.new(:inargs, :callargs, :retvals, :pre, :post)
    class ArgData
      def initialize
	super
	self.inargs = []
	self.callargs = []
	self.retvals = []
	self.pre = []
	self.post = []
      end
    end

    KEYWORDS =  [
      "alias", "and", "begin", "break", "case", "class", "def", "do",
      "else", "elsif", "end", "ensure", "false", "for", "if", "in",
      "module", "next", "nil", "not", "or", "redo", "rescue", "retry",
      "return", "self", "super", "then", "true", "undef", "unless",
      "until", "when", "while", "yield"
    ]

    def initialize info, libmodule
      @info = info
      @libmodule = libmodule
    end

    def generate
      setup_accumulators
      process_return_value
      @info.args.each {|a| process_arg a}
      adjust_accumulators
      return filled_out_template
    end

    private

    def setup_accumulators
      @inargs = []
      @callargs = []
      @retvals = []

      @pre = []
      @post = []

      @data = []

      @capture = ""

      @varno = 0
    end

    def process_arg arg
      data = case arg.direction
      when :inout
	process_inout_arg arg
      when :in
	process_in_arg arg
      when :out
	process_out_arg arg
      else
	raise ArgumentError
      end

      @data << data
    end

    def process_inout_arg arg
      raise NotImplementedError unless arg.ownership_transfer == :everything

      data = ArgData.new

      tag = arg.type.tag

      name = safe arg.name
      prevar = new_var
      postvar = new_var

      data.inargs << name
      data.callargs << prevar
      data.retvals << postvar

      case tag
      when :interface
	raise NotImplementedError
      when :array
	tag = arg.type.param_type(0).tag
	data.pre << "#{prevar} = GirFFI::ArgHelper.#{tag}_array_to_inoutptr #{name}"
	if arg.type.array_length > -1
	  idx = arg.type.array_length
	  rv = @data[idx].retvals.shift
	  data.post << "#{postvar} = GirFFI::ArgHelper.outptr_to_#{tag}_array #{prevar}, #{rv}"
	else
	  data.post << "#{postvar} = GirFFI::ArgHelper.outptr_to_#{tag}_array #{prevar}, #{name}.nil? ? 0 : #{name}.size"
	end
      else
	arr_arg = find_counted_array(name)
	if arr_arg
	  data.inargs.pop
	  data.pre << "#{prevar} = GirFFI::ArgHelper.#{tag}_to_inoutptr #{arr_arg.name}.length"
	else
	  data.pre << "#{prevar} = GirFFI::ArgHelper.#{tag}_to_inoutptr #{name}"
	end
	data.post << "#{postvar} = GirFFI::ArgHelper.outptr_to_#{tag} #{prevar}"
      end

      data
    end

    def process_out_arg arg
      data = ArgData.new
      type = arg.type
      tag = type.tag

      prevar = new_var
      postvar = new_var

      data.callargs << prevar
      data.retvals << postvar

      case tag
      when :interface
	iface = arg.type.interface
	if iface.type == :struct
	  data.pre << "#{prevar} = #{iface.namespace}::#{iface.name}.new"
	  data.post << "#{postvar} = #{prevar}"
	else
	  raise NotImplementedError,
	    "Don't know what to do with interface type #{iface.type}"
	end
      when :array
	size = type.array_fixed_size
	tag = arg.type.param_type(0).tag
	data.pre << "#{prevar} = GirFFI::ArgHelper.pointer_pointer"
	data.post << "#{postvar} = GirFFI::ArgHelper.outptr_to_#{tag}_array #{prevar}, #{size}"
      else
	data.pre << "#{prevar} = GirFFI::ArgHelper.#{tag}_pointer"
	data.post << "#{postvar} = GirFFI::ArgHelper.outptr_to_#{tag} #{prevar}"
      end

      data
    end

    def process_in_arg arg
      data = ArgData.new

      name = safe arg.name
      type = arg.type
      tag = type.tag

      data.inargs << name

      case tag
      when :interface
	if type.interface.type == :callback
	  procvar = new_var
	  data.pre << "#{procvar} = GirFFI::ArgHelper.mapped_callback_args #{name}"
	  # TODO: Use arg.scope to decide if this is needed.
	  data.pre << "::#{@libmodule}::CALLBACKS << #{procvar}"
	  data.callargs << procvar
	else
	  data.callargs << name
	end
      when :void
	raise NotImplementedError unless arg.type.pointer?
	prevar = new_var
	data.pre << "#{prevar} = GirFFI::ArgHelper.object_to_inptr #{name}"
	data.callargs << prevar
      when :array
	if type.array_fixed_size > 0
	  data.pre << "GirFFI::ArgHelper.check_fixed_array_size #{type.array_fixed_size}, #{name}, \"#{name}\""
	elsif type.array_length > -1
	  idx = type.array_length
	  @data[idx].inargs = []
	  lenvar = new_var
	  data.pre << "#{lenvar} = #{name}.length"
	  @data[idx].callargs = [lenvar]
	end

	prevar = new_var

	tag = arg.type.param_type(0).tag
	data.pre << "#{prevar} = GirFFI::ArgHelper.#{tag}_array_to_inptr #{name}"
	unless arg.ownership_transfer == :everything
	  # TODO: Call different cleanup method for strings
	  data.post << "GirFFI::ArgHelper.cleanup_inptr #{prevar}"
	end

	data.callargs << prevar
      else
	data.callargs << name
      end

      data
    end

    def process_return_value
      type = @info.return_type
      tag = type.tag
      return if tag == :void
      cvar = new_var
      @capture = "#{cvar} = "

      case tag
      when :interface
	interface = type.interface
	namespace = interface.namespace
	name = interface.name
	GirFFI::Builder.build_class namespace, name
	retval = new_var
	@post << "#{retval} = ::#{namespace}::#{name}._real_new(#{cvar})"
	if interface.type == :object
	  @post << "GirFFI::ArgHelper.sink_if_floating(#{retval})"
	end
	@retvals << retval
      when :array
	size = type.array_fixed_size
	tag = type.param_type(0).tag
	retval = new_var
	@post << "#{retval} = GirFFI::ArgHelper.ptr_to_#{tag}_array #{cvar}, #{size}"
	@retvals << retval
      else
	@retvals << cvar
      end
    end

    def find_counted_array name
      @info.args.each do |arg|
	al = arg.type.array_length
	if al >= 0 and @info.args[al].name == name
	  return arg
	end
      end
    end

    def adjust_accumulators
      @data.each do |data|
	@inargs += data.inargs
	@callargs += data.callargs
	@retvals += data.retvals
	@pre += data.pre
	@post += data.post
      end

      if @info.throws?
	errvar = new_var
	@pre << "#{errvar} = FFI::MemoryPointer.new(:pointer).write_pointer nil"
	@post.unshift "GirFFI::ArgHelper.check_error(#{errvar})"
	@callargs << errvar
      end

      @post << "return #{@retvals.join(', ')}" unless @retvals.empty?

      if @info.method?
	@callargs.unshift "self"
      end
    end

    def filled_out_template
      return <<-CODE
	def #{@info.name} #{@inargs.compact.join(', ')}
	  #{@pre.join("\n")}
	  #{@capture}::#{@libmodule}.#{@info.symbol} #{@callargs.join(', ')}
	  #{@post.join("\n")}
	end
      CODE
    end

    def new_var
      @varno += 1
      "_v#{@varno}"
    end

    def safe name
      if KEYWORDS.include? name
	"#{name}_"
      else
	name
      end
    end
  end
end
