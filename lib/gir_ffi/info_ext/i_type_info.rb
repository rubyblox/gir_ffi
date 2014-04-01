require 'gir_ffi/builder_helper'

module GirFFI
  module InfoExt
    # Extensions for GObjectIntrospection::ITypeInfo needed by GirFFI
    module ITypeInfo

      def self.flattened_tag_to_gtype_map
        @flattened_tag_to_gtype_map ||= {
          :array => GObject::TYPE_ARRAY,
          :c => GObject::TYPE_POINTER,
          :gboolean => GObject::TYPE_BOOLEAN,
          :ghash => GObject::TYPE_HASH_TABLE,
          :gint32 => GObject::TYPE_INT,
          :gint64 => GObject::TYPE_INT64,
          :guint64 => GObject::TYPE_UINT64,
          :strv => GObject::TYPE_STRV,
          :utf8 => GObject::TYPE_STRING,
          :void => GObject::TYPE_NONE
        }
      end

      def g_type
        if tag == :interface
          interface.g_type
        else
          ITypeInfo.flattened_tag_to_gtype_map[flattened_tag] or
            raise "Can't find type for #{flattened_tag} pointer? = #{pointer?}"
        end
      end

      def make_g_value
        GObject::Value.for_g_type g_type
      end

      def element_type
        case tag
        when :glist, :gslist, :array, :c
          enumerable_element_type 
        when :ghash
          dictionary_element_type
        else
          nil
        end
      end

      def flattened_tag
        case tag
        when :interface
          interface_type
        when :array
          flattened_array_type
        else
          tag
        end
      end

      def interface_type
        tag == :interface && interface.info_type
      end

      def tag_or_class
        base = case tag
               when:interface
                 Builder.build_class interface
               when :ghash
                 [tag, *element_type]
               else
                 flattened_tag
               end
        if pointer? && tag != :utf8 && tag != :filename
          [:pointer, base]
        else
          base
        end
      end

      TAG_TO_WRAPPER_CLASS_MAP = {
        :array => 'GLib::Array',
        :byte_array => 'GLib::ByteArray',
        :c => 'GirFFI::SizedArray',
        :error => 'GLib::Error',
        :ghash => 'GLib::HashTable',
        :glist => 'GLib::List',
        :gslist => 'GLib::SList',
        :ptr_array => 'GLib::PtrArray',
        :strv => 'GLib::Strv',
        :utf8 => 'GirFFI::InPointer',
        :void => 'GirFFI::InPointer',
        :zero_terminated => 'GirFFI::ZeroTerminated'
      }

      # TODO: Use class rather than class name
      def argument_class_name
        if tag == :interface
          interface.full_type_name
        else
          TAG_TO_WRAPPER_CLASS_MAP[flattened_tag]
        end
      end

      def to_ffitype
        return :pointer if pointer?

        case tag
        when :interface
          interface.to_ffitype
        when :array
          [subtype_ffitype(0), array_fixed_size]
        else
          TypeMap.map_basic_type tag
        end
      end

      def to_callback_ffitype
        return :pointer if pointer?

        if tag == :interface
          case interface.info_type
          when :enum, :flags
            :int32
          else
            :pointer
          end
        else
          TypeMap.map_basic_type tag
        end
      end

      def needs_ruby_to_c_conversion_for_functions?
        [ :array, :c, :callback, :ghash, :glist, :gslist, :object, :ptr_array,
          :struct, :strv, :utf8, :void, :zero_terminated ].include?(flattened_tag)
      end

      def needs_conversion_for_functions?
        [ :array, :byte_array, :c, :error, :filename, :ghash, :glist,
          :gslist, :interface, :object, :ptr_array, :struct, :strv, :union,
          :utf8, :zero_terminated ].include?(flattened_tag)
      end

      def needs_conversion_for_callbacks?
        [:callback, :enum].include?(flattened_tag) || needs_conversion_for_functions?
      end

      def extra_conversion_arguments
        case flattened_tag
        when :utf8, :void
          [flattened_tag]
        when :c
          [element_type, array_fixed_size]
        when :array, :ghash, :glist, :gslist, :ptr_array, :zero_terminated
          [element_type]
        else
          []
        end
      end

      private

      def subtype_tag_or_class index
        param_type(index).tag_or_class
      end

      def dictionary_element_type
        [subtype_tag_or_class(0), subtype_tag_or_class(1)]
      end

      def enumerable_element_type
        subtype_tag_or_class 0
      end

      def subtype_ffitype(index)
        subtype = param_type(index).to_ffitype
        if subtype == :pointer
          # NOTE: Don't use pointer directly to appease JRuby.
          :"uint#{FFI.type_size(:pointer)*8}"
        else
          subtype
        end
      end

      def flattened_array_type
        if zero_terminated?
          zero_terminated_array_type
        else
          array_type
        end
      end

      def zero_terminated_array_type
        case element_type
        when :utf8, :filename
          :strv
        else
          :zero_terminated
        end
      end
    end
  end
end

GObjectIntrospection::ITypeInfo.send :include, GirFFI::InfoExt::ITypeInfo
