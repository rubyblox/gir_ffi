require 'gir_ffi_test_helper'

describe GirFFI::FieldBuilder do
  let(:instance) { GirFFI::FieldBuilder.new field_info }

  describe "for a field of type :gint8 with an offset" do
    let(:field_info) { get_field_introspection_data "Regress", "TestSimpleBoxedA", "some_int8" }
    it "creates the right getter method" do
      expected = <<-CODE.reset_indentation
        def some_int8
          _v1 = @struct.to_ptr + #{field_info.offset}
          _v2 = GirFFI::InOutPointer.new(:gint8, _v1)
          _v3 = _v2.to_value
          
          _v3
        end
      CODE
      instance.getter_def.must_equal expected
    end
  end

  describe "for a field of type :struct" do
    let(:field_info) { get_field_introspection_data "Regress", "TestBoxed", "nested_a" }
    it "creates the right getter method" do
      expected = <<-CODE.reset_indentation
        def nested_a
          _v1 = @struct.to_ptr + #{field_info.offset}
          _v2 = GirFFI::InOutPointer.new(Regress::TestSimpleBoxedA, _v1)
          _v3 = _v2.to_value
          _v4 = ::Regress::TestSimpleBoxedA.wrap(_v3)
          _v4
        end
      CODE
      instance.getter_def.must_equal expected
    end
  end

  describe "for a field of type :enum" do
    let(:field_info) { get_field_introspection_data "Regress", "TestStructA", "some_enum" }
    it "creates the right getter method" do
      expected = <<-CODE.reset_indentation
        def some_enum
          _v1 = @struct.to_ptr + #{field_info.offset}
          _v2 = GirFFI::InOutPointer.new(Regress::TestEnum, _v1)
          _v3 = _v2.to_value
          
          _v3
        end
      CODE
      instance.getter_def.must_equal expected
    end
  end
end
