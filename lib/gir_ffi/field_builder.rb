require 'gir_ffi/argument_builder'
require 'gir_ffi/return_value_builder'
require 'gir_ffi/variable_name_generator'
require 'gir_ffi/setter_argument_info'

module GirFFI
  # Creates field getter and setter code for a given IFieldInfo.
  class FieldBuilder
    def initialize field_info, lib_module, struct_class
      @info = field_info
      @libmodule = lib_module
      @struct_class = struct_class
    end

    def getter_def
      builder = return_value_builder

      return <<-CODE
      def #{@info.name}
        struct = #{@struct_class}.new @struct.to_ptr
        #{builder.callarg} = struct[#{field_symbol.inspect}]
        #{builder.post.join("\n")}
        #{builder.retval}
      end
      CODE
    end

    def setter_def
      builder = setter_builder
      name = @info.name

      return <<-CODE
      def #{name}= #{builder.inarg}
        #{builder.pre.join("\n")}
        struct = #{@struct_class}.new @struct.to_ptr
        struct[#{name.to_sym.inspect}] = #{builder.callarg}
      end
      CODE
    end

    private

    def field_symbol
      @info.name.to_sym
    end

    def return_value_builder
      vargen = VariableNameGenerator.new
      @rv_builder ||= ReturnValueBuilder.new vargen, @info.field_type, false
    end

    def setter_builder
      vargen = VariableNameGenerator.new
      argument_info = SetterArgumentInfo.new "value", @info.field_type
      ArgumentBuilder.new vargen, argument_info
    end
  end
end
