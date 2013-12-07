require 'gir_ffi/builders/return_value_builder'

module GirFFI
  module Builders
    # TODO: Fix name of #post method
    class CallbackArgumentBuilder < BaseArgumentBuilder
      class Convertor
        def initialize type_info, argument_name, length_arg
          @type_info = type_info
          @argument_name = argument_name
          @length_arg = length_arg
        end

        def conversion
          if conversion_needed?
            case @type_info.flattened_tag
            when :utf8, :filename
              "#{@argument_name}.to_utf8"
            else
              "#{@type_info.argument_class_name}.wrap(#{conversion_arguments})"
            end
          else
            @argument_name
          end
        end

        def conversion_needed?
          @type_info.flattened_tag == :enum ||
            [ :array, :byte_array, :c, :error, :filename, :ghash, :glist,
              :gslist, :interface, :object, :ptr_array, :struct, :strv, :union,
              :utf8, :zero_terminated ].include?(@type_info.flattened_tag)
        end

        private

        def conversion_arguments
          if @type_info.flattened_tag == :c
            "#{@type_info.subtype_tag_or_class.inspect}, #{array_size}, #{@argument_name}"
          else
            @type_info.extra_conversion_arguments.map(&:inspect).push(@argument_name).join(", ")
          end
        end

        def array_size
          if @length_arg
            @length_arg.retname
          else
            @type_info.array_fixed_size
          end
        end
      end

      def pre_conversion
        if has_pre_conversion?
          [ "#{retname} = #{pre_conversion_implementation}" ]
        else
          []
        end
      end

      def inarg
        nil
      end

      def retval
        super if is_relevant?
      end

      def is_relevant?
        !is_void_return_value? && !arginfo.skip?
      end

      def retname
        @retname ||= if has_pre_conversion?
                       new_variable
                     else
                       method_argument_name
                     end
      end

      def method_argument_name
        @method_argument_name ||= name || new_variable
      end

      private

      def has_pre_conversion?
        is_closure || pre_convertor.conversion_needed?
      end

      def pre_convertor
        @pre_convertor ||= Convertor.new(type_info, method_argument_name, length_arg)
      end

      def pre_conversion_implementation
        if is_closure
          "GirFFI::ArgHelper::OBJECT_STORE[#{method_argument_name}.address]"
        else
          pre_convertor.conversion
        end
      end

      def is_void_return_value?
        specialized_type_tag == :void && !type_info.pointer?
      end
    end
  end
end
