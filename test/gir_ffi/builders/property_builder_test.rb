require 'gir_ffi_test_helper'

describe GirFFI::Builders::PropertyBuilder do
  let(:builder) { GirFFI::Builders::PropertyBuilder.new property_info }

  describe "for a property of type :glist" do
    let(:property_info) { get_property_introspection_data("Regress", "TestObj", "list") }
    it "generates the correct getter definition" do
      expected = <<-CODE.reset_indentation
      def list
        _v1 = get_property_basic("list").get_value_plain
        _v2 = GLib::List.wrap(:utf8, _v1)
        _v2
      end
      CODE

      builder.getter_def.must_equal expected
    end
  end
end
