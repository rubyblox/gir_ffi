# coding: utf-8
require 'gir_ffi_test_helper'

GirFFI.setup :Regress

def get_field_value obj, field
  struct = obj.instance_variable_get :@struct
  struct[field]
end

# Tests generated methods and functions in the Regress namespace.
describe Regress do
  describe Regress::Lib do
    it "extends GirFFI::Library" do
      class << Regress::Lib
        self.must_be :include?, GirFFI::Library
      end
    end
  end
  describe "Regress::ATestError" do
    before do
      skip unless get_introspection_data 'Regress', 'ATestError'
    end

    it "has the member :code0" do
      Regress::ATestError[:code0].must_equal 0
    end

    it "has the member :code1" do
      Regress::ATestError[:code1].must_equal 1
    end

    it "has the member :code2" do
      Regress::ATestError[:code2].must_equal 2
    end
  end

  it "has the constant DOUBLE_CONSTANT" do
    assert_equal 44.22, Regress::DOUBLE_CONSTANT
  end

  it "has the constant GUINT64_CONSTANT" do
    skip unless get_introspection_data 'Regress', 'GUINT64_CONSTANT'
    Regress::GUINT64_CONSTANT.must_equal 18446744073709551615
  end

  it "has the constant GUINT64_CONSTANTA" do
    skip unless get_introspection_data 'Regress', 'GUINT64_CONSTANTA'
    Regress::GUINT64_CONSTANTA.must_equal 18446744073709551615
  end

  it "has the constant G_GINT64_CONSTANT" do
    skip unless get_introspection_data 'Regress', 'G_GINT64_CONSTANT'
    Regress::G_GINT64_CONSTANT.must_equal 1000
  end

  it "has the constant INT_CONSTANT" do
    assert_equal 4422, Regress::INT_CONSTANT
  end

  it "has the constant LONG_STRING_CONSTANT" do
    Regress::LONG_STRING_CONSTANT.must_equal %w(TYPE VALUE ENCODING CHARSET
                                                LANGUAGE DOM INTL POSTAL PARCEL
                                                HOME WORK PREF VOICE FAX MSG
                                                CELL PAGER BBS MODEM CAR ISDN
                                                VIDEO AOL APPLELINK ATTMAIL CIS
                                                EWORLD INTERNET IBMMAIL MCIMAIL
                                                POWERSHARE PRODIGY TLX X400 GIF
                                                CGM WMF BMP MET PMB DIB PICT
                                                TIFF PDF PS JPEG QTIME MPEG
                                                MPEG2 AVI WAVE AIFF PCM X509
                                                PGP).join(",")
  end

  describe "Regress::LikeGnomeKeyringPasswordSchema" do
    before do
      skip unless get_introspection_data 'Regress', 'LikeGnomeKeyringPasswordSchema'
    end
    it "creates an instance using #new" do
      obj = Regress::LikeGnomeKeyringPasswordSchema.new
      obj.must_be_instance_of Regress::LikeGnomeKeyringPasswordSchema
    end

    let(:instance) { Regress::LikeGnomeKeyringPasswordSchema.new }

    it "has a writable field dummy" do
      instance.dummy.must_equal 0
      instance.dummy = 42
      instance.dummy.must_equal 42
    end

    it "has a writable field attributes" do
      skip "This does not work yet"
      instance.attributes
    end

    it "has a writable field dummy2" do
      instance.dummy2.must_equal 0.0
      instance.dummy2 = 42.42
      instance.dummy2.must_equal 42.42
    end
  end

  it "has the constant MAXUINT64" do
    skip unless get_introspection_data 'Regress', 'MAXUINT64'
    Regress::MAXUINT64.must_equal 0xffff_ffff_ffff_ffff
  end

  it "has the constant MININT64" do
    skip unless get_introspection_data 'Regress', 'MININT64'
    Regress::MININT64.must_equal(-0x8000_0000_0000_0000)
  end

  it "has the constant Mixed_Case_Constant" do
    assert_equal 4423, Regress::Mixed_Case_Constant
  end

  it "has the constant NEGATIVE_INT_CONSTANT" do
    skip unless get_introspection_data 'Regress', 'NEGATIVE_INT_CONSTANT'
    Regress::NEGATIVE_INT_CONSTANT.must_equal(-42)
  end

  it "has the constant STRING_CONSTANT" do
    assert_equal "Some String", Regress::STRING_CONSTANT
  end

  describe "Regress::TestABCError" do
    before do
      skip unless get_introspection_data 'Regress', 'TestABCError'
    end

    it "has the member :code1" do
      Regress::TestABCError[:code1].must_equal 1
    end

    it "has the member :code2" do
      Regress::TestABCError[:code2].must_equal 2
    end

    it "has the member :code3" do
      Regress::TestABCError[:code3].must_equal 3
    end

    it "has a working function #quark" do
      quark = Regress::TestABCError.quark
      GLib.quark_to_string(quark).must_equal "regress-test-abc-error"
    end
  end

  describe "Regress::TestBoxed" do
    let(:instance) { Regress::TestBoxed.new_alternative_constructor1 123 }

    it "has a writable field some_int8" do
      instance.some_int8.must_equal 123
      instance.some_int8 = -43
      instance.some_int8.must_equal(-43)
    end

    it "has a writable field nested_a" do
      instance.nested_a.some_int.must_equal 0
      nested = Regress::TestSimpleBoxedA.new
      nested.some_int = 12345
      instance.nested_a = nested
      instance.nested_a.some_int.must_equal 12345
    end

    it "has a writable field priv" do
      instance.priv.wont_be_nil
      other = Regress::TestBoxed.new
      instance.priv.wont_equal other.priv
      instance.priv = other.priv
      instance.priv.must_equal other.priv
    end

    it "creates an instance using #new" do
      tb = Regress::TestBoxed.new
      assert_instance_of Regress::TestBoxed, tb
    end

    it "creates an instance using #new_alternative_constructor1" do
      tb = Regress::TestBoxed.new_alternative_constructor1 1
      assert_instance_of Regress::TestBoxed, tb
      assert_equal 1, tb.some_int8
    end

    it "creates an instance using #new_alternative_constructor2" do
      tb = Regress::TestBoxed.new_alternative_constructor2 1, 2
      assert_instance_of Regress::TestBoxed, tb
      assert_equal 1 + 2, tb.some_int8
    end

    it "creates an instance using #new_alternative_constructor3" do
      tb = Regress::TestBoxed.new_alternative_constructor3 "54"
      assert_instance_of Regress::TestBoxed, tb
      assert_equal 54, tb.some_int8
    end

    it "has non-zero positive result for #get_gtype" do
      assert Regress::TestBoxed.get_gtype > 0
    end

    it "has a working method #copy" do
      tb2 = instance.copy
      assert_instance_of Regress::TestBoxed, tb2
      assert_equal 123, tb2.some_int8
      instance.some_int8 = 89
      assert_equal 123, tb2.some_int8
    end

    it "has a working method #equals" do
      tb2 = Regress::TestBoxed.new_alternative_constructor2 120, 3
      assert_equal true, instance.equals(tb2)
    end
  end

  describe "Regress::TestBoxedB" do
    let(:instance) { Regress::TestBoxedB.new 8, 42 }

    it "has a writable field some_int8" do
      instance.some_int8.must_equal 8
      instance.some_int8 = -43
      instance.some_int8.must_equal(-43)
    end

    it "has a writable field some_long" do
      instance.some_long.must_equal 42
      instance.some_long = -4342
      instance.some_long.must_equal(-4342)
    end

    it "creates an instance using #new" do
      tb = Regress::TestBoxedB.new 8, 42
      assert_instance_of Regress::TestBoxedB, tb
    end

    it "has a working method #copy" do
      cp = instance.copy
      cp.must_be_instance_of Regress::TestBoxedB
      cp.some_int8.must_equal 8
      cp.some_long.must_equal 42
      instance.some_int8 = 2
      cp.some_int8.must_equal 8
    end
  end

  describe "Regress::TestBoxedC" do
    before do
      skip unless get_introspection_data 'Regress', 'TestBoxedC'
    end

    let(:instance) { Regress::TestBoxedC.new }

    it "has a writable field refcount" do
      instance.refcount.must_equal 1
      instance.refcount = 2
      instance.refcount.must_equal 2
    end

    it "has a writable field another_thing" do
      instance.another_thing.must_equal 42
      instance.another_thing = 4342
      instance.another_thing.must_equal 4342
    end

    it "creates an instance using #new" do
      tb = Regress::TestBoxedC.new
      assert_instance_of Regress::TestBoxedC, tb
    end
  end

  describe "Regress::TestBoxedD" do
    before do
      skip unless get_introspection_data 'Regress', 'TestBoxedD'
    end

    it "creates an instance using #new" do
      instance = Regress::TestBoxedD.new "foo", 42
      instance.must_be_instance_of Regress::TestBoxedD
    end

    it "has a working method #copy" do
      instance = Regress::TestBoxedD.new "foo", 42
      copy = instance.copy
      copy.must_be_instance_of Regress::TestBoxedD
      instance.get_magic.must_equal copy.get_magic
      instance.wont_equal copy
    end

    it "has a working method #free" do
      instance = Regress::TestBoxedD.new "foo", 42
      instance.free
      pass
    end

    it "has a working method #get_magic" do
      instance = Regress::TestBoxedD.new "foo", 42
      instance.get_magic.must_equal "foo".length + 42
    end
  end

  describe "Regress::TestDEFError" do
    before do
      skip unless get_introspection_data 'Regress', 'TestDEFError'
    end
    it "has the member :code0" do
      Regress::TestDEFError[:code0].must_equal 0
    end

    it "has the member :code1" do
      Regress::TestDEFError[:code1].must_equal 1
    end

    it "has the member :code2" do
      Regress::TestDEFError[:code2].must_equal 2
    end
  end

  describe "Regress::TestEnum" do
    it "has the member :value1" do
      Regress::TestEnum[:value1].must_equal 0
    end

    it "has the member :value2" do
      Regress::TestEnum[:value2].must_equal 1
    end

    it "has the member :value3" do
      Regress::TestEnum[:value3].must_equal(-1)
    end

    it "has the member :value4" do
      Regress::TestEnum[:value4].must_equal 48
    end

    it "has a working function #param" do
      Regress::TestEnum.param(:value1).must_equal("value1")
      Regress::TestEnum.param(:value2).must_equal("value2")
      Regress::TestEnum.param(:value3).must_equal("value3")
      Regress::TestEnum.param(:value4).must_equal("value4")
      Regress::TestEnum.param(0).must_equal("value1")
      Regress::TestEnum.param(1).must_equal("value2")
      Regress::TestEnum.param(-1).must_equal("value3")
      Regress::TestEnum.param(48).must_equal("value4")
    end
  end

  describe "Regress::TestEnumNoGEnum" do
    it "has the member :evalue1" do
      Regress::TestEnumNoGEnum[:evalue1].must_equal 0
    end

    it "has the member :evalue2" do
      Regress::TestEnumNoGEnum[:evalue2].must_equal 42
    end

    it "has the member :evalue3" do
      Regress::TestEnumNoGEnum[:evalue3].must_equal 48
    end
  end

  describe "Regress::TestEnumUnsigned" do
    it "has the member :value1" do
      Regress::TestEnumUnsigned[:value1].must_equal 1
    end

    # NOTE In c, the positive and negative values are not distinguished
    it "has the member :value2" do
      Regress::TestEnumUnsigned[:value2].must_equal(-2147483648)
    end
  end

  describe "Regress::TestError" do
    before do
      skip unless get_introspection_data 'Regress', 'TestError'
    end

    it "has the member :code1" do
      Regress::TestError[:code1].must_equal 1
    end

    it "has the member :code2" do
      Regress::TestError[:code2].must_equal 2
    end

    it "has the member :code3" do
      Regress::TestError[:code3].must_equal 3
    end

    it "has a working function #quark" do
      quark = Regress::TestError.quark
      GLib.quark_to_string(quark).must_equal "regress-test-error"
    end
  end

  describe "Regress::TestFlags" do
    it "has the member :flag1" do
      assert_equal 1, Regress::TestFlags[:flag1]
    end
    it "has the member :flag2" do
      assert_equal 2, Regress::TestFlags[:flag2]
    end
    it "has the member :flag3" do
      assert_equal 4, Regress::TestFlags[:flag3]
    end
  end

  describe "Regress::TestFloating" do
    it "creates an instance using #new" do
      o = Regress::TestFloating.new
      o.must_be_instance_of Regress::TestFloating
    end

    describe "an instance" do
      before do
        @o = Regress::TestFloating.new
      end

      it "has a reference count of 1" do
        assert_equal 1, ref_count(@o)
      end

      it "has been sunk" do
        assert !is_floating?(@o)
      end
    end
  end

  describe "Regress::TestFundamentalObject" do
    it "does not have GObject::Object as an ancestor" do
      refute_includes Regress::TestFundamentalObject.ancestors,
        GObject::Object
    end

    it "cannot be instanciated" do
      proc { Regress::TestFundamentalObject.new }.must_raise NoMethodError
    end

    it "has a working method #ref" do
      skip "Can only be tested in the descendent class"
    end

    it "has a working method #unref" do
      skip "Can only be tested in the descendent class"
    end
  end

  describe "Regress::TestFundamentalSubObject" do
    it "creates an instance using #new" do
      obj = Regress::TestFundamentalSubObject.new "foo"
      obj.must_be_instance_of Regress::TestFundamentalSubObject
    end

    let(:instance) { Regress::TestFundamentalSubObject.new "foo" }

    it "is a subclass of TestFundamentalObject" do
      assert_kind_of Regress::TestFundamentalObject, instance
    end

    it "has a field :data storing the constructor parameter" do
      assert_equal "foo", instance.data
    end

    it "can access its parent class' fields directly" do
      instance.flags.must_equal 0
    end

    # NOTE: The following tests test fields and methods on the abstract parent
    # class.
    it "has a refcount of 1" do
      assert_equal 1, instance.refcount
    end

    it "has a working method #ref" do
      instance.ref
      instance.refcount.must_equal 2
    end

    it "has a working method #unref" do
      instance.unref
      instance.refcount.must_equal 0
    end
  end

  describe "Regress::TestInterface" do
    it "is a module" do
      assert_instance_of Module, Regress::TestInterface
    end

    it "extends InterfaceBase" do
      metaclass = class << Regress::TestInterface; self; end
      assert_includes metaclass.ancestors, GirFFI::InterfaceBase
    end

    it "has non-zero positive result for #get_gtype" do
      Regress::TestInterface.get_gtype.must_be :>, 0
    end
  end

  describe "Regress::TestObj" do
    it "creates an instance using #constructor" do
      obj = Regress::TestObj.constructor
      obj.must_be_instance_of Regress::TestObj
    end

    it "creates an instance using #new" do
      o1 = Regress::TestObj.constructor
      o2 = Regress::TestObj.new o1
      o2.must_be_instance_of Regress::TestObj
    end

    it "creates an instance using #new_callback" do
      a = 1
      o = Regress::TestObj.new_callback Proc.new { a = 2 }, nil, nil
      assert_instance_of Regress::TestObj, o
      a.must_equal 2
    end

    it "creates an instance using #new_from_file" do
      o = Regress::TestObj.new_from_file("foo")
      assert_instance_of Regress::TestObj, o
    end

    it "has a working function #null_out" do
      obj = Regress::TestObj.null_out
      obj.must_be_nil
    end

    it "has a working function #static_method" do
      rv = Regress::TestObj.static_method 623
      assert_equal 623.0, rv
    end

    it "has a working function #static_method_callback" do
      a = 1
      Regress::TestObj.static_method_callback Proc.new { a = 2 }
      assert_equal 2, a
    end

    let(:instance) { Regress::TestObj.new_from_file("foo") }

    describe "its gtype" do
      it "can be found through get_gtype and GObject.type_from_instance" do
        gtype = Regress::TestObj.get_gtype
        r = GObject.type_from_instance instance
        assert_equal gtype, r
      end
    end

    it "has a reference count of 1" do
      assert_equal 1, ref_count(instance)
    end

    it "does not float" do
      assert !is_floating?(instance)
    end

    it "has a working method #matrix" do
      instance.matrix("bar").must_equal 42
    end

    it "has a working method #do_matrix" do
      instance.do_matrix("bar").must_equal 42
    end

    it "has a working method #emit_sig_with_foreign_struct" do
      skip unless get_method_introspection_data('Regress', 'TestObj',
                                                'emit_sig_with_foreign_struct')
      has_fired = false
      instance.signal_connect "sig-with-foreign-struct" do |obj, cr|
        has_fired = true
        cr.must_be_instance_of Cairo::Context
      end
      instance.emit_sig_with_foreign_struct
      assert has_fired
    end

    it "has a working method #emit_sig_with_int64" do
      skip "This does not work yet"
      instance.signal_connect "sig-with-int64-prop" do |obj, i, ud|
        int
      end
      instance.emit_sig_with_int64
    end

    it "has a working method #emit_sig_with_obj" do
      has_fired = false
      instance.signal_connect "sig-with-obj" do |it, obj|
        has_fired = true
        obj.int.must_equal 3
      end
      instance.emit_sig_with_obj
      assert has_fired
    end

    it "has a working method #emit_sig_with_uint64" do
      skip "This does not work yet"
      instance.signal_connect "sig-with-uint64-prop" do |obj, i, ud|
        i
      end
      instance.emit_sig_with_uint64
    end

    it "has a working method #forced_method" do
      instance.forced_method
      pass
    end

    it "has a working method #instance_method" do
      rv = instance.instance_method
      assert_equal(-1, rv)
    end

    it "has a working method #instance_method_callback" do
      a = 1
      instance.instance_method_callback Proc.new { a = 2 }
      assert_equal 2, a
    end

    it "has a working method #set_bare" do
      obj = Regress::TestObj.new_from_file("bar")
      # XXX: Sometimes uses set_property, and it shouldn't?
      instance.set_bare obj
      instance.bare.must_equal obj
    end

    it "has a working method #skip_inout_param" do
      a = 1
      c = 2.0
      num1 = 3
      num2 = 4
      result, out_b, sum = instance.skip_inout_param a, c, num1, num2
      result.must_equal true
      out_b.must_equal a + 1
      sum.must_equal num1 + 10 * num2
    end

    it "has a working method #skip_out_param" do
      a = 1
      c = 2.0
      d = 3
      num1 = 4
      num2 = 5
      result, out_d, sum = instance.skip_out_param a, c, d, num1, num2
      result.must_equal true
      out_d.must_equal d + 1
      sum.must_equal num1 + 10 * num2
    end

    it "has a working method #skip_param" do
      a = 1
      d = 3
      num1 = 4
      num2 = 5
      result, out_b, out_d, sum = instance.skip_param a, d, num1, num2
      result.must_equal true
      out_b.must_equal a + 1
      out_d.must_equal d + 1
      sum.must_equal num1 + 10 * num2
    end

    it "has a working method #skip_return_val" do
      a = 1
      c = 2.0
      d = 3
      num1 = 4
      num2 = 5
      out_b, out_d, out_sum = instance.skip_return_val a, c, d, num1, num2
      out_b.must_equal a + 1
      out_d.must_equal d + 1
      out_sum.must_equal num1 + 10 * num2
    end

    it "has a working method #skip_return_val_no_out" do
      result = instance.skip_return_val_no_out 1
      result.must_be_nil

      lambda { instance.skip_return_val_no_out 0 }.must_raise RuntimeError
    end

    it "has a working method #torture_signature_0" do
      y, z, q = instance.torture_signature_0(-21, "hello", 13)
      assert_equal [-21, 2 * -21, "hello".length + 13],
        [y, z, q]
    end

    it "has a working method #torture_signature_1" do
      ret, y, z, q = instance.torture_signature_1(-21, "hello", 12)
      assert_equal [true, -21, 2 * -21, "hello".length + 12],
        [ret, y, z, q]
      assert_raises RuntimeError do
        instance.torture_signature_1(-21, "hello", 11)
      end
    end

    describe "its 'bare' property" do
      it "can be retrieved with #get_property" do
        instance.get_property("bare").must_be_nil
      end

      it "can be retrieved with #bare" do
        instance.bare.must_be_nil
      end

      it "can be set with #set_property" do
        obj = Regress::TestObj.new_from_file("bar")
        instance.set_property "bare", obj
        instance.get_property("bare").must_equal obj
      end

      it "can be set with #bare=" do
        obj = Regress::TestObj.new_from_file("bar")
        instance.bare = obj

        instance.bare.must_equal obj
        instance.get_property("bare").must_equal obj
      end
    end

    describe "its 'boxed' property" do
      it "can be retrieved with #get_property" do
        instance.get_property("boxed").must_be_nil
      end

      it "can be retrieved with #boxed" do
        instance.boxed.must_be_nil
      end

      it "can be set with #set_property" do
        tb = Regress::TestBoxed.new_alternative_constructor1 75
        instance.set_property "boxed", tb
        instance.get_property("boxed").some_int8.must_equal 75
      end

      it "can be set with #boxed=" do
        tb = Regress::TestBoxed.new_alternative_constructor1 75
        instance.boxed = tb
        instance.boxed.some_int8.must_equal tb.some_int8
        instance.get_property("boxed").some_int8.must_equal tb.some_int8
      end
    end

    describe "its 'double' property" do
      it "can be retrieved with #get_property" do
        instance.get_property("double").must_equal 0.0
      end

      it "can be retrieved with #double" do
        instance.double.must_equal 0.0
      end

      it "can be set with #set_property" do
        instance.set_property "double", 3.14
        instance.get_property("double").must_equal 3.14
      end

      it "can be set with #double=" do
        instance.double = 3.14
        instance.double.must_equal 3.14
        instance.get_property("double").must_equal 3.14
      end
    end

    describe "its 'float' property" do
      it "can be retrieved with #get_property" do
        instance.get_property("float").must_equal 0.0
      end

      it "can be retrieved with #float" do
        instance.float.must_equal 0.0
      end

      it "can be set with #set_property" do
        instance.set_property "float", 3.14
        instance.get_property("float").must_be_close_to 3.14
      end

      it "can be set with #float=" do
        instance.float = 3.14
        instance.float.must_be_close_to 3.14
        instance.get_property("float").must_be_close_to 3.14
      end
    end

    describe "its 'gtype' property" do
      before do
        skip unless get_property_introspection_data("Regress", "TestObj", "gtype")
      end

      it "can be retrieved with #get_property" do
        instance.get_property("gtype").must_equal 0
      end

      it "can be retrieved with #gtype" do
        instance.gtype.must_equal 0
      end

      it "can be set with #set_property" do
        instance.set_property "gtype", GObject::TYPE_INT64
        instance.get_property("gtype").must_equal GObject::TYPE_INT64
      end

      it "can be set with #gtype=" do
        instance.gtype = GObject::TYPE_STRING
        instance.gtype.must_equal GObject::TYPE_STRING
        instance.get_property("gtype").must_equal GObject::TYPE_STRING
      end
    end

    describe "its 'hash-table' property" do
      it "can be retrieved with #get_property" do
        instance.get_property("hash-table").must_be_nil
      end

      it "can be retrieved with #hash_table" do
        instance.hash_table.must_be_nil
      end

      it "can be set with #set_property" do
        instance.set_property "hash-table", {"foo" => 34, "bar" => 83}
        instance.get_property("hash-table").to_hash.must_equal({"foo" => 34,
                                                                "bar" => 83})
      end

      it "can be set with #hash_table=" do
        instance.set_property "hash-table", {"foo" => 34, "bar" => 83}
        instance.hash_table.to_hash.must_equal({"foo" => 34, "bar" => 83})
        instance.get_property("hash-table").to_hash.must_equal({"foo" => 34,
                                                                "bar" => 83})
      end
    end

    describe "its 'hash-table-old' property" do
      it "can be retrieved with #get_property" do
        instance.get_property("hash-table-old").must_be_nil
      end

      it "can be retrieved with #hash_table_old" do
        instance.hash_table_old.must_be_nil
      end

      it "can be set with #set_property" do
        instance.set_property "hash-table-old", {"foo" => 34,
                                                 "bar" => 83}

        instance.get_property("hash-table-old").to_hash.must_equal({"foo" => 34,
                                                                    "bar" => 83})
      end

      it "can be set with #hash_table_old=" do
        instance.set_property "hash-table-old", {"foo" => 34,
                                                 "bar" => 83}

        instance.hash_table_old.to_hash.must_equal({"foo" => 34, "bar" => 83})
        instance.get_property("hash-table-old").to_hash.must_equal({"foo" => 34,
                                                                    "bar" => 83})
      end
    end

    describe "its 'int' property" do
      it "can be retrieved with #get_property" do
        assert_equal 0, instance.get_property("int")
      end

      it "can be retrieved with #int" do
        assert_equal 0, instance.int
      end

      it "can be set with #set_property" do
        instance.set_property "int", 42
        assert_equal 42, instance.get_property("int")
      end

      it "can be set with #int=" do
        instance.int = 41
        assert_equal 41, instance.get_property("int")
        assert_equal 41, instance.int
      end
    end

    describe "its 'list' property" do
      it "can be retrieved with #get_property" do
        instance.get_property("list").must_be_nil
      end

      it "can be retrieved with #list" do
        instance.list.must_be_nil
      end

      it "can be set with #set_property" do
        instance.set_property "list", ["foo", "bar"]
        instance.get_property("list").must_be :==, ["foo", "bar"]
      end

      it "can be set with #list=" do
        instance.list = ["foo", "bar"]
        instance.list.must_be :==, ["foo",  "bar"]
        instance.get_property("list").must_be :==, ["foo", "bar"]
      end
    end

    describe "its 'list-old' property" do
      it "can be retrieved with #get_property" do
        instance.get_property("list-old").must_be_nil
      end

      it "can be retrieved with #list_old" do
        instance.list_old.must_be_nil
      end

      it "can be set with #set_property" do
        instance.set_property "list-old", ["foo", "bar"]
        instance.get_property("list-old").must_be :==, ["foo", "bar"]
      end

      it "can be set with #list_old=" do
        instance.list_old = ["foo", "bar"]
        instance.list_old.must_be :==, ["foo",  "bar"]
        instance.get_property("list-old").must_be :==, ["foo", "bar"]
      end
    end

    describe "its 'string' property" do
      it "can be retrieved with #get_property" do
        assert_nil instance.get_property("string")
      end

      it "can be retrieved with #string" do
        assert_nil instance.string
      end

      it "can be set with #set_property" do
        instance.set_property "string", "foobar"
        assert_equal "foobar", instance.get_property("string")
      end

      it "can be set with #string=" do
        instance.string = "foobar"
        assert_equal "foobar", instance.string
        assert_equal "foobar", instance.get_property("string")
      end
    end

    it "handles the 'all' signal" do
      a = nil
      GObject.signal_connect(instance, "all") { a = 4 }
      GObject.signal_emit instance, "all"
      a.must_equal 4
    end

    it "handles the 'cleanup' signal" do
      a = nil
      GObject.signal_connect(instance, "cleanup") { a = 4 }
      GObject.signal_emit instance, "cleanup"
      a.must_equal 4
    end

    it "handles the 'first' signal" do
      a = nil
      GObject.signal_connect(instance, "first") { a = 4 }
      GObject.signal_emit instance, "first"
      a.must_equal 4
    end

    it "handles the 'sig-with-array-len-prop' signal" do
      skip
    end

    it "handles the 'sig-with-array-prop' signal" do
      skip
    end
    it "handles the 'sig-with-foreign-struct' signal" do
      skip
    end
    it "handles the 'sig-with-hash-prop' signal" do
      skip
    end
    it "handles the 'sig-with-int64-prop' signal" do
      skip
    end
    it "handles the 'sig-with-intarray-ret' signal" do
      skip
    end
    it "handles the 'sig-with-obj' signal" do
      skip
    end
    it "handles the 'sig-with-strv' signal" do
      skip
    end
    it "handles the 'sig-with-uint64-prop' signal" do
      skip
    end

    it "handles the 'test' signal" do
      a = b = nil
      o = Regress::TestSubObj.new
      GObject.signal_connect(o, "test", 2) { |i, d| a = d; b = i }
      GObject.signal_emit o, "test"
      assert_equal [2, o], [a, b]
    end
    it "handles the 'test-with-static-scope-arg' signal" do
      skip
    end
  end

  describe "Regress::TestOtherError" do
    before do
      skip unless get_introspection_data 'Regress', 'TestOtherError'
    end

    it "has the member :code1" do
      Regress::TestOtherError[:code1].must_equal 1
    end

    it "has the member :code2" do
      Regress::TestOtherError[:code2].must_equal 2
    end

    it "has the member :code3" do
      Regress::TestOtherError[:code3].must_equal 3
    end

    it "has a working function #quark" do
      quark = Regress::TestOtherError.quark
      GLib.quark_to_string(quark).must_equal "regress-test-other-error"
    end
  end

  describe "Regress::TestPrivateEnum" do
    it "has the member :public_enum_before" do
      Regress::TestPrivateEnum[:public_enum_before].must_equal 1
    end
    it "does not have the member :private" do
      Regress::TestPrivateEnum[:private].must_equal nil
    end
    it "has the member :public_enum_after" do
      Regress::TestPrivateEnum[:public_enum_after].must_equal 4
    end
  end

  describe "Regress::TestPrivateStruct" do
    let(:instance) { Regress::TestPrivateStruct.new }

    it "has a writable field this_is_public_before" do
      instance.this_is_public_before.must_equal 0
      instance.this_is_public_before = 42
      instance.this_is_public_before.must_equal 42
    end

    it "has a private field this_is_private" do
      skip "GIR identifies this field as readable"
      proc { instance.this_is_private }.must_raise NoMethodError
      proc { instance.this_is_private = 42 }.must_raise NoMethodError
    end

    it "has a writable field this_is_public_after" do
      instance.this_is_public_after.must_equal 0
      instance.this_is_public_after = 42
      instance.this_is_public_after.must_equal 42
    end
  end

  describe "Regress::TestReferenceEnum" do
    before do
      skip unless get_introspection_data 'Regress', 'TestReferenceEnum'
    end
    it "has the member :0" do
      Regress::TestReferenceEnum[:"0"].must_equal 4
    end
    it "has the member :1" do
      Regress::TestReferenceEnum[:"1"].must_equal 2
    end
    it "has the member :2" do
      Regress::TestReferenceEnum[:"2"].must_equal 54
    end
    it "has the member :3" do
      Regress::TestReferenceEnum[:"3"].must_equal 4
    end
    it "has the member :4" do
      Regress::TestReferenceEnum[:"4"].must_equal 216
    end
    it "has the member :5" do
      Regress::TestReferenceEnum[:"5"].must_equal(-217)
    end
  end

  describe "Regress::TestSimpleBoxedA" do
    it "creates an instance using #new" do
      obj = Regress::TestSimpleBoxedA.new
      assert_instance_of Regress::TestSimpleBoxedA, obj
    end

    it "has a working method #copy" do
      skip
    end
    it "has a working method #equals" do
      skip
    end
    it "has a working function #const_return" do
      skip
    end

    describe "an instance" do
      before do
        @obj = Regress::TestSimpleBoxedA.new
        @obj.some_int = 4236
        @obj.some_int8 = 36
        @obj.some_double = 23.53
        @obj.some_enum = :value2
      end

      describe "its equals method" do
        before do
          @ob2 = Regress::TestSimpleBoxedA.new
          @ob2.some_int = 4236
          @ob2.some_int8 = 36
          @ob2.some_double = 23.53
          @ob2.some_enum = :value2
        end

        it "returns true if values are the same" do
          assert_equal true, @obj.equals(@ob2)
        end

        it "returns true if enum values differ" do
          @ob2.some_enum = :value3
          assert_equal true, @obj.equals(@ob2)
        end

        it "returns false if other values differ" do
          @ob2.some_int = 1
          assert_equal false, @obj.equals(@ob2)
        end
      end

      describe "its copy method" do
        before do
          @ob2 = @obj.copy
        end

        it "returns an instance of TestSimpleBoxedA" do
          assert_instance_of Regress::TestSimpleBoxedA, @ob2
        end

        it "copies fields" do
          assert_equal 4236, @ob2.some_int
          assert_equal 36, @ob2.some_int8
          assert_equal 23.53, @ob2.some_double
          assert_equal :value2, @ob2.some_enum
        end

        it "creates a true copy" do
          @obj.some_int8 = 89
          assert_equal 36, @ob2.some_int8
        end
      end
    end
  end

  describe "Regress::TestSimpleBoxedB" do
    it "has a writable field some_int8" do
      skip
    end
    it "has a writable field nested_a" do
      skip
    end
    it "has a working method #copy" do
      skip
    end
  end

  describe "Regress::TestStructA" do
    let(:instance) { Regress::TestStructA.new }
    it "has a writable field some_int" do
      instance.some_int.must_equal 0
      instance.some_int = 2556
      instance.some_int.must_equal 2556
    end

    it "has instance writable field some_int8" do
      instance.some_int8.must_equal 0
      instance.some_int8 = -10
      instance.some_int8.must_equal(-10)
    end

    it "has instance writable field some_double" do
      instance.some_double.must_equal 0.0
      instance.some_double = 1.03455e20
      instance.some_double.must_equal 1.03455e20
    end

    it "has instance writable field some_enum" do
      instance.some_enum.must_equal :value1
      instance.some_enum = :value2
      instance.some_enum.must_equal :value2
    end

    it "has a working method #clone" do
      a = Regress::TestStructA.new
      a.some_int = 2556
      a.some_int8 = -10
      a.some_double = 1.03455e20
      a.some_enum = :value2

      b = a.clone

      assert_equal 2556, b.some_int
      assert_equal(-10, b.some_int8)
      assert_equal 1.03455e20, b.some_double
      assert_equal :value2, b.some_enum
    end

    it "has a working function #parse" do
      a = Regress::TestStructA.parse("this string is actually ignored")
      a.some_int.must_equal 23
    end
  end

  describe "Regress::TestStructB" do
    it "has a writable field some_int8" do
      skip
    end
    it "has a writable field nested_a" do
      skip
    end
    it "has a working method #clone" do
      a = Regress::TestStructB.new
      a.some_int8 = 42
      a.nested_a.some_int = 2556
      a.nested_a.some_int8 = -10
      a.nested_a.some_double = 1.03455e20
      a.nested_a.some_enum = :value2

      b = a.clone

      assert_equal 42, b.some_int8
      assert_equal 2556, b.nested_a.some_int
      assert_equal(-10, b.nested_a.some_int8)
      assert_equal 1.03455e20, b.nested_a.some_double
      assert_equal :value2, b.nested_a.some_enum
    end
  end

  describe "Regress::TestStructC" do
    let(:instance) { Regress::TestStructC.new }
    it "has a writable field another_int" do
      instance.another_int.must_equal 0
      instance.another_int = 42
      instance.another_int.must_equal 42
    end

    it "has a writable field obj" do
      o = Regress::TestSubObj.new
      instance.obj.must_equal nil
      instance.obj = o
      instance.obj.must_equal o
    end
  end

  describe "Regress::TestStructD" do
    let(:instance) { Regress::TestStructD.new }
    it "has a writable field array1" do
      instance.array1.must_be :==, []
      struct = Regress::TestStructA.new
      instance.array1 = [struct]
      instance.array1.must_be :==, [struct]
    end

    it "has a writable field array2" do
      instance.array2.must_be :==, []
      o = Regress::TestSubObj.new
      instance.array2 = [o]
      instance.array2.must_be :==, [o]
    end

    it "has a writable field field" do
      instance.field.must_equal nil
      o = Regress::TestSubObj.new
      instance.field = o
      instance.field.must_equal o
    end
  end

  describe "Regress::TestStructE" do
    it "must be tested" do
      skip
    end
  end
  describe "Regress::TestStructE__some_union__union" do
    it "has a writable field v_int" do
      skip
    end
    it "has a writable field v_uint" do
      skip
    end
    it "has a writable field v_long" do
      skip
    end
    it "has a writable field v_ulong" do
      skip
    end
    it "has a writable field v_int64" do
      skip
    end
    it "has a writable field v_uint64" do
      skip
    end
    it "has a writable field v_float" do
      skip
    end
    it "has a writable field v_double" do
      skip
    end
    it "has a writable field v_pointer" do
      skip
    end
  end
  describe "Regress::TestStructF" do
    it "has a writable field ref_count" do
      skip
    end
    it "has a writable field data1" do
      skip
    end
    it "has a writable field data2" do
      skip
    end
    it "has a writable field data3" do
      skip
    end
    it "has a writable field data4" do
      skip
    end
    it "has a writable field data5" do
      skip
    end
    it "has a writable field data6" do
      skip
    end
  end
  describe "Regress::TestStructFixedArray" do
    it "has a writable field just_int" do
      skip
    end
    it "has a writable field array" do
      skip
    end
    it "has a working method #frob" do
      skip
    end
  end

  describe "Regress::TestSubObj" do
    it "creates an instance using #new" do
      tso = Regress::TestSubObj.new
      assert_instance_of Regress::TestSubObj, tso
    end

    let(:instance) { Regress::TestSubObj.new }

    it "has a working method #instance_method" do
      res = instance.instance_method
      assert_equal 0, res
    end

    it "has a working method #unset_bare" do
      instance.unset_bare
      pass
    end

    it "does not have a field parent_instance" do
      assert_raises(NoMethodError) { instance.parent_instance }
    end
  end

  describe "Regress::TestWi8021x" do
    it "creates an instance using #new" do
      o = Regress::TestWi8021x.new
      assert_instance_of Regress::TestWi8021x, o
    end

    it "has a working function #static_method" do
      assert_equal(-84, Regress::TestWi8021x.static_method(-42))
    end

    let(:instance) { Regress::TestWi8021x.new }

    it "has a working method #get_testbool" do
      instance.set_testbool false
      assert_equal false, instance.get_testbool
      instance.set_testbool true
      assert_equal true, instance.get_testbool
    end

    it "has a working method #set_testbool" do
      instance.set_testbool true
      assert_equal true, get_field_value(instance, :testbool)
      instance.set_testbool false
      assert_equal false, get_field_value(instance, :testbool)
    end

    describe "its 'testbool' property" do
      before do
        @obj = instance
      end

      it "can be retrieved with #get_property" do
        @obj.set_testbool true
        val = @obj.get_property "testbool"
        assert_equal true, val
      end

      it "can be retrieved with #testbool" do
        @obj.set_testbool true
        assert_equal true, @obj.testbool
        @obj.set_testbool false
        assert_equal false, @obj.testbool
      end

      it "can be set with #set_property" do
        skip
      end

      it "can be set with #testbool=" do
        @obj.testbool = true
        assert_equal true, @obj.testbool
        @obj.testbool = false
        assert_equal false, @obj.testbool
      end
    end
  end

  it "has the constant UTF8_CONSTANT" do
    assert_equal "const ♥ utf8", Regress::UTF8_CONSTANT
  end

  it "has a working function #aliased_caller_alloc" do
    skip
  end
  it "has a working function #atest_error_quark" do
    skip
  end
  it "has a working function #func_obj_null_in" do
    skip
  end
  it "has a working function #global_get_flags_out" do
    skip
  end
  it "has a working function #has_parameter_named_attrs" do
    skip
  end
  it "has a working function #introspectable_via_alias" do
    skip
  end

  it "has a working function #set_abort_on_error" do
    Regress.set_abort_on_error false
    Regress.set_abort_on_error true
  end

  it "has a working function #test_abc_error_quark" do
    skip
  end
  it "has a working function #test_array_callback" do
    skip
  end

  it "has a working function #test_array_fixed_out_objects" do
    result = Regress.test_array_fixed_out_objects
    gtype = Regress::TestObj.get_gtype

    result.size.must_equal 2

    result.each {|o|
      assert_instance_of Regress::TestObj, o
      assert_equal gtype, GObject.type_from_instance(o)
    }
  end

  it "has a working function #test_array_fixed_size_int_in" do
    assert_equal 5 + 4 + 3 + 2 + 1, Regress.test_array_fixed_size_int_in([5, 4, 3, 2, 1])
  end

  describe "#test_array_fixed_size_int_in" do
    it "raises an error when called with the wrong number of arguments" do
      assert_raises ArgumentError do
        Regress.test_array_fixed_size_int_in [2]
      end
    end
  end

  it "has a working function #test_array_fixed_size_int_out" do
    Regress.test_array_fixed_size_int_out.must_be :==, [0, 1, 2, 3, 4]
  end

  it "has a working function #test_array_fixed_size_int_return" do
    Regress.test_array_fixed_size_int_return.must_be :==, [0, 1, 2, 3, 4]
  end

  it "has a working function #test_array_gint16_in" do
    assert_equal 5 + 4 + 3, Regress.test_array_gint16_in([5, 4, 3])
  end

  it "has a working function #test_array_gint32_in" do
    assert_equal 5 + 4 + 3, Regress.test_array_gint32_in([5, 4, 3])
  end

  it "has a working function #test_array_gint64_in" do
    assert_equal 5 + 4 + 3, Regress.test_array_gint64_in([5, 4, 3])
  end

  it "has a working function #test_array_gint8_in" do
    assert_equal 5 + 4 + 3, Regress.test_array_gint8_in([5, 4, 3])
  end

  it "has a working function #test_array_gtype_in" do
    t1 = GObject.type_from_name "gboolean"
    t2 = GObject.type_from_name "gint64"
    assert_equal "[gboolean,gint64,]", Regress.test_array_gtype_in([t1, t2])
  end

  it "has a working function #test_array_int_full_out" do
    Regress.test_array_int_full_out.must_be :==, [0, 1, 2, 3, 4]
  end

  it "has a working function #test_array_int_in" do
    assert_equal 5 + 4 + 3, Regress.test_array_int_in([5, 4, 3])
  end

  it "has a working function #test_array_int_inout" do
    Regress.test_array_int_inout([5, 2, 3]).must_be :==, [3, 4]
  end

  it "has a working function #test_array_int_none_out" do
    Regress.test_array_int_none_out.must_be :==, [1, 2, 3, 4, 5]
  end

  it "has a working function #test_array_int_null_in" do
    Regress.test_array_int_null_in nil
    pass
  end

  it "has a working function #test_array_int_null_out" do
    assert_equal nil, Regress.test_array_int_null_out
  end

  it "has a working function #test_array_int_out" do
    Regress.test_array_int_out.must_be :==, [0, 1, 2, 3, 4]
  end

  it "has a working function #test_async_ready_callback" do
    main_loop = GLib::MainLoop.new nil, false

    a = 1
    Regress.test_async_ready_callback Proc.new {
      main_loop.quit
      a = 2
    }

    main_loop.run

    assert_equal 2, a
  end

  it "has a working function #test_boolean" do
    assert_equal false, Regress.test_boolean(false)
    assert_equal true, Regress.test_boolean(true)
  end

  it "has a working function #test_boolean_false" do
    assert_equal false, Regress.test_boolean_false(false)
  end

  it "has a working function #test_boolean_true" do
    assert_equal true, Regress.test_boolean_true(true)
  end

  it "has a working function #test_cairo_context_full_return" do
    ct = Regress.test_cairo_context_full_return
    assert_instance_of Cairo::Context, ct
  end

  it "has a working function #test_cairo_context_none_in" do
    ct = Regress.test_cairo_context_full_return
    Regress.test_cairo_context_none_in ct
  end

  it "has a working function #test_cairo_surface_full_out" do
    cs = Regress.test_cairo_surface_full_out
    assert_instance_of Cairo::Surface, cs
  end

  it "has a working function #test_cairo_surface_full_return" do
    cs = Regress.test_cairo_surface_full_return
    assert_instance_of Cairo::Surface, cs
  end

  it "has a working function #test_cairo_surface_none_in" do
    cs = Regress.test_cairo_surface_full_return
    Regress.test_cairo_surface_none_in cs
  end

  it "has a working function #test_cairo_surface_none_return" do
    cs = Regress.test_cairo_surface_none_return
    assert_instance_of Cairo::Surface, cs
  end

  it "has a working function #test_callback" do
    result = Regress.test_callback Proc.new { 5 }
    assert_equal 5, result
  end

  it "has a working function #test_callback_async" do
    a = 1
    Regress.test_callback_async Proc.new {|b|
      a = 2
      b
    }, 44
    r = Regress.test_callback_thaw_async
    assert_equal 44, r
    assert_equal 2, a
  end

  it "has a working function #test_callback_destroy_notify" do
    a = 1
    r1 = Regress.test_callback_destroy_notify Proc.new {|b|
      a = 2
      b
    }, 42, Proc.new { a = 3 }
    assert_equal 2, a
    assert_equal 42, r1
    r2 = Regress.test_callback_thaw_notifications
    assert_equal 3, a
    assert_equal 42, r2
  end

  it "has a working function #test_callback_destroy_notify_no_user_data" do
    skip
  end
  it "has a working function #test_callback_thaw_async" do
    skip
  end
  it "has a working function #test_callback_thaw_notifications" do
    skip
  end

  it "has a working function #test_callback_user_data" do
    a = "old-value"
    result = Regress.test_callback_user_data Proc.new {|u|
      a = u
      5
    }, "new-value"
    a.must_equal "new-value"
    result.must_equal 5
  end

  describe "the #test_callback_user_data function" do
    it "handles boolean user_data" do
      a = false
      Regress.test_callback_user_data Proc.new {|u|
        a = u
        5
      }, true
      assert_equal true, a
    end
  end

  it "has a working function #test_closure" do
    c = GObject::RubyClosure.new { 5235 }
    r = Regress.test_closure c
    assert_equal 5235, r
  end

  it "has a working function #test_closure_one_arg" do
    c = GObject::RubyClosure.new { |a| a * 2 }
    r = Regress.test_closure_one_arg c, 2
    assert_equal 4, r
  end

  it "has a working function #test_closure_variant" do
    skip
  end

  it "has a working function #test_date_in_gvalue" do
    r = Regress.test_date_in_gvalue
    date = r.get_value
    skip unless date.respond_to? :get_year
    assert_equal [1984, :december, 5],
      [date.get_year, date.get_month, date.get_day]
  end

  it "has a working function #test_def_error_quark" do
    skip
  end

  it "has a working function #test_double" do
    r = Regress.test_double 5435.32
    assert_equal 5435.32, r
  end

  it "has a working function #test_enum_param" do
    r = Regress.test_enum_param :value3
    assert_equal "value3", r
  end

  it "has a working function #test_error_quark" do
    skip
  end

  # TODO: Find a way to test encoding issues.
  it "has a working function #test_filename_return" do
    arr = Regress.test_filename_return
    arr.must_be :==, ["åäö", "/etc/fstab"]
  end

  it "has a working function #test_float" do
    r = Regress.test_float 5435.32
    assert_in_delta 5435.32, r, 0.001
  end

  it "has a working function #test_garray_container_return" do
    arr = Regress.test_garray_container_return
    arr.must_be_instance_of GLib::PtrArray
    arr.len.must_equal 1

    ptr = arr.pdata
    ptr2 = ptr.read_pointer
    ptr2.read_string.must_be :==, "regress"
  end

  it "has a working function #test_garray_full_return" do
    skip
  end
  it "has a working function #test_gerror_callback" do
    skip
  end

  it "has a working function #test_ghash_container_return" do
    hash = Regress.test_ghash_container_return
    hash.must_be_instance_of GLib::HashTable
    hash.to_hash.must_equal("foo" => "bar",
                            "baz" => "bat",
                            "qux" => "quux")
  end

  it "has a working function #test_ghash_everything_return" do
    ghash = Regress.test_ghash_everything_return
    ghash.to_hash.must_be :==, {"foo" => "bar",
                                "baz" => "bat",
                                "qux" => "quux"}
  end

  it "has a working function #test_ghash_gvalue_in" do
    skip
  end
  it "has a working function #test_ghash_gvalue_return" do
    skip
  end
  it "has a working function #test_ghash_nested_everything_return" do
    skip
  end
  it "has a working function #test_ghash_nested_everything_return2" do
    skip
  end

  it "has a working function #test_ghash_nothing_in" do
    Regress.test_ghash_nothing_in({"foo" => "bar",
                                   "baz" => "bat",
                                   "qux" => "quux"})
  end

  it "has a working function #test_ghash_nothing_in2" do
    Regress.test_ghash_nothing_in2({"foo" => "bar",
                                    "baz" => "bat",
                                    "qux" => "quux"})
  end

  it "has a working function #test_ghash_nothing_return" do
    ghash = Regress.test_ghash_nothing_return
    ghash.to_hash.must_be :==, {"foo" => "bar",
                                "baz" => "bat",
                                "qux" => "quux"}
  end

  it "has a working function #test_ghash_nothing_return2" do
    ghash = Regress.test_ghash_nothing_return2
    ghash.to_hash.must_be :==, {"foo" => "bar",
                                "baz" => "bat",
                                "qux" => "quux"}
  end

  it "has a working function #test_ghash_null_in" do
    Regress.test_ghash_null_in(nil)
  end

  it "has a working function #test_ghash_null_out" do
    ghash = Regress.test_ghash_null_out
    ghash.must_be_nil
  end

  it "has a working function #test_ghash_null_return" do
    ghash = Regress.test_ghash_null_return
    ghash.must_be_nil
  end

  it "has a working function #test_glist_container_return" do
    list = Regress.test_glist_container_return
    assert_instance_of GLib::List, list
    list.must_be :==, ["1", "2", "3"]
  end

  it "has a working function #test_glist_everything_return" do
    list = Regress.test_glist_everything_return
    list.must_be :==, ["1", "2", "3"]
  end

  it "has a working function #test_glist_nothing_in" do
    Regress.test_glist_nothing_in ["1", "2", "3"]
    pass
  end

  it "has a working function #test_glist_nothing_in2" do
    Regress.test_glist_nothing_in2 ["1", "2", "3"]
    pass
  end

  it "has a working function #test_glist_nothing_return" do
    list = Regress.test_glist_nothing_return
    list.must_be :==, ["1", "2", "3"]
  end

  it "has a working function #test_glist_nothing_return2" do
    list = Regress.test_glist_nothing_return2
    list.must_be :==, ["1", "2", "3"]
  end

  it "has a working function #test_glist_null_in" do
    Regress.test_glist_null_in nil
    pass
  end

  it "has a working function #test_glist_null_out" do
    result = Regress.test_glist_null_out
    assert_equal nil, result
  end

  it "has a working function #test_gslist_container_return" do
    slist = Regress.test_gslist_container_return
    assert_instance_of GLib::SList, slist
    slist.must_be :==, ["1", "2", "3"]
  end

  it "has a working function #test_gslist_everything_return" do
    slist = Regress.test_gslist_everything_return
    slist.must_be :==, ["1", "2", "3"]
  end

  it "has a working function #test_gslist_nothing_in" do
    Regress.test_gslist_nothing_in ["1", "2", "3"]
    pass
  end

  it "has a working function #test_gslist_nothing_in2" do
    Regress.test_gslist_nothing_in2 ["1", "2", "3"]
    pass
  end

  it "has a working function #test_gslist_nothing_return" do
    slist = Regress.test_gslist_nothing_return
    slist.must_be :==, ["1", "2", "3"]
  end

  it "has a working function #test_gslist_nothing_return2" do
    slist = Regress.test_gslist_nothing_return2
    slist.must_be :==, ["1", "2", "3"]
  end

  it "has a working function #test_gslist_null_in" do
    Regress.test_gslist_null_in nil
    pass
  end

  it "has a working function #test_gslist_null_out" do
    result = Regress.test_gslist_null_out
    assert_equal nil, result
  end

  it "has a working function #test_gtype" do
    result = Regress.test_gtype 23
    assert_equal 23, result
  end

  it "has a working function #test_gvariant_as" do
    skip
  end
  it "has a working function #test_gvariant_asv" do
    skip
  end
  it "has a working function #test_gvariant_i" do
    skip
  end
  it "has a working function #test_gvariant_s" do
    skip
  end
  it "has a working function #test_gvariant_v" do
    skip
  end
  it "has a working function #test_hash_table_callback" do
    skip
  end

  it "has a working function #test_int" do
    result = Regress.test_int 23
    assert_equal 23, result
  end

  it "has a working function #test_int16" do
    result = Regress.test_int16 23
    assert_equal 23, result
  end

  it "has a working function #test_int32" do
    result = Regress.test_int32 23
    assert_equal 23, result
  end

  it "has a working function #test_int64" do
    result = Regress.test_int64 2300000000000
    assert_equal 2300000000000, result
  end

  it "has a working function #test_int8" do
    result = Regress.test_int8 23
    assert_equal 23, result
  end

  it "has a working function #test_int_out_utf8" do
    len = Regress.test_int_out_utf8 "How long?"
    assert_equal 9, len
  end

  it "has a working function #test_int_value_arg" do
    gv = GObject::Value.new
    gv.init GObject.type_from_name "gint"
    gv.set_int 343
    result = Regress.test_int_value_arg gv
    assert_equal 343, result
  end

  it "has a working function #test_long" do
    long_val = FFI.type_size(:long) == 8 ? 2_300_000_000_000 : 2_000_000_000
    result = Regress.test_long long_val
    assert_equal long_val, result
  end

  it "has a working function #test_multi_callback" do
    a = 1
    result = Regress.test_multi_callback Proc.new {
      a += 1
      23
    }
    assert_equal 2 * 23, result
    assert_equal 3, a
  end

  it "has a working function #test_multi_double_args" do
    one, two = Regress.test_multi_double_args 23.1
    assert_equal 2 * 23.1, one
    assert_equal 3 * 23.1, two
  end

  it "has a working function #test_multiline_doc_comments" do
    skip
  end
  it "has a working function #test_nested_parameter" do
    skip
  end
  it "has a working function #test_null_gerror_callback" do
    skip
  end
  it "has a working function #test_owned_gerror_callback" do
    skip
  end

  it "has a working function #test_short" do
    result = Regress.test_short 23
    assert_equal 23, result
  end

  it "has a working function #test_simple_boxed_a_const_return" do
    result = Regress.test_simple_boxed_a_const_return
    assert_equal [5, 6, 7.0], [result.some_int, result.some_int8, result.some_double]
  end

  it "has a working function #test_simple_callback" do
    a = 0
    Regress.test_simple_callback Proc.new { a = 1 }
    assert_equal 1, a
  end

  it "has a working function #test_size" do
    assert_equal 2354, Regress.test_size(2354)
  end

  it "has a working function #test_ssize" do
    assert_equal(-2_000_000, Regress.test_ssize(-2_000_000))
  end

  it "has a working function #test_struct_a_parse" do
    skip
  end

  it "has a working function #test_strv_in" do
    assert_equal true, Regress.test_strv_in(['1', '2', '3'])
  end

  it "has a working function #test_strv_in_gvalue" do
    gv = Regress.test_strv_in_gvalue
    gv.get_value.must_be :==, ['one', 'two', 'three']
  end

  it "has a working function #test_strv_out" do
    arr = Regress.test_strv_out
    arr.must_be :==, ["thanks", "for", "all", "the", "fish"]
  end

  it "has a working function #test_strv_out_c" do
    arr = Regress.test_strv_out_c
    arr.must_be :==, ["thanks", "for", "all", "the", "fish"]
  end

  it "has a working function #test_strv_out_container" do
    arr = Regress.test_strv_out_container
    arr.must_be :==, ['1', '2', '3']
  end

  it "has a working function #test_strv_outarg" do
    arr = Regress.test_strv_outarg
    arr.must_be :==, ['1', '2', '3']
  end

  it "has a working function #test_timet" do
    # Time rounded to seconds.
    t = Time.at(Time.now.to_i)
    result = Regress.test_timet(t.to_i)
    assert_equal t, Time.at(result)
  end

  it "has a working function #test_torture_signature_0" do
    y, z, q = Regress.test_torture_signature_0 86, "foo", 2
    assert_equal [86, 2*86, 3+2], [y, z, q]
  end

  it "has a working function #test_torture_signature_1" do
    ret, y, z, q = Regress.test_torture_signature_1(-21, "hello", 12)
    assert_equal [true, -21, 2 * -21, "hello".length + 12], [ret, y, z, q]

    assert_raises RuntimeError do
      Regress.test_torture_signature_1(-21, "hello", 11)
    end
  end

  it "has a working function #test_torture_signature_2" do
    a = 1
    y, z, q = Regress.test_torture_signature_2 244,
      Proc.new {|u| a = u }, 2, Proc.new { a = 3 },
      "foofoo", 31
    assert_equal [244, 2*244, 6+31], [y, z, q]
    assert_equal 3, a
  end

  it "has a working function #test_uint" do
    assert_equal 31, Regress.test_uint(31)
  end

  it "has a working function #test_uint16" do
    assert_equal 31, Regress.test_uint16(31)
  end

  it "has a working function #test_uint32" do
    assert_equal 540000, Regress.test_uint32(540000)
  end

  it "has a working function #test_uint64" do
    assert_equal 54_000_000_000_000, Regress.test_uint64(54_000_000_000_000)
  end

  it "has a working function #test_uint8" do
    assert_equal 31, Regress.test_uint8(31)
  end

  it "has a working function #test_ulong" do
    assert_equal 54_000_000_000_000, Regress.test_uint64(54_000_000_000_000)
  end

  it "has a working function #test_unconventional_error_quark" do
    skip unless get_introspection_data 'Regress', 'test_unconventional_error_quark'
    result = Regress.test_unconventional_error_quark
    GLib.quark_to_string(result).must_equal "regress-test-other-error"
  end

  it "has a working function #test_unichar" do
    assert_equal 120, Regress.test_unichar(120)
    assert_equal 540_000, Regress.test_unichar(540_000)
  end

  it "has a working function #test_unsigned_enum_param" do
    assert_equal "value1", Regress.test_unsigned_enum_param(:value1)
    assert_equal "value2", Regress.test_unsigned_enum_param(:value2)
  end

  it "has a working function #test_ushort" do
    assert_equal 54_000_000, Regress.test_uint64(54_000_000)
  end

  it "has a working function #test_utf8_const_in" do
    Regress.test_utf8_const_in("const \xe2\x99\xa5 utf8")
    pass
  end

  it "has a working function #test_utf8_const_return" do
    result = Regress.test_utf8_const_return
    assert_equal "const \xe2\x99\xa5 utf8", result
  end

  it "has a working function #test_utf8_inout" do
    result = Regress.test_utf8_inout "const \xe2\x99\xa5 utf8"
    assert_equal "nonconst \xe2\x99\xa5 utf8", result
  end

  it "has a working function #test_utf8_nonconst_return" do
    result = Regress.test_utf8_nonconst_return
    assert_equal "nonconst \xe2\x99\xa5 utf8", result
  end

  it "has a working function #test_utf8_null_in" do
    Regress.test_utf8_null_in nil
    pass
  end

  it "has a working function #test_utf8_null_out" do
    assert_equal nil, Regress.test_utf8_null_out
  end

  it "has a working function #test_utf8_out" do
    result = Regress.test_utf8_out
    assert_equal "nonconst \xe2\x99\xa5 utf8", result
  end

  it "has a working function #test_utf8_out_nonconst_return" do
    r, out = Regress.test_utf8_out_nonconst_return
    assert_equal ["first", "second"], [r, out]
  end

  it "has a working function #test_utf8_out_out" do
    out0, out1 = Regress.test_utf8_out_nonconst_return
    assert_equal ["first", "second"], [out0, out1]
  end

  it "has a working function #test_value_return" do
    result = Regress.test_value_return 3423
    assert_equal 3423, result.get_int
  end

  it "has a working function #test_versioning" do
    skip unless get_introspection_data 'Regress', 'test_versioning'
    Regress.test_versioning
    pass
  end

  it "raises an appropriate NoMethodError when a function is not found" do
    begin
      Regress.this_method_does_not_exist
    rescue => e
      e.message.must_match(/^undefined method `this_method_does_not_exist' (for Regress:Module|on Regress \(Module\))$/)
    end
  end
end
