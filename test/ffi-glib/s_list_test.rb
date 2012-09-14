require 'gir_ffi_test_helper'

describe GLib::SList do
  it "knows its element type" do
    arr = GLib::SList.new :gint32
    assert_equal :gint32, arr.element_type
  end

  describe "#prepend" do
    it "prepends integer values" do
      lst = GLib::SList.new :gint32
      res = lst.prepend 1
      assert_equal 1, res.data
    end

    it "prepends string values" do
      lst = GLib::SList.new :utf8
      res = lst.prepend "bla"
      assert_equal "bla", res.data
    end

    it "prepends multiple values into a single list" do
      lst = GLib::SList.new :gint32

      res = lst.prepend 1
      res2 = res.prepend 2

      assert_equal 2, res2.data
      assert_equal 1, res.data
      assert_equal res.to_ptr, res2.next.to_ptr
    end
  end

  describe "::from" do
    it "creates a GSList from a Ruby array" do
      lst = GLib::SList.from :gint32, [3, 2, 1]
      assert_equal [3, 2, 1], lst.to_a
    end

    it "return its argument if given a GSList" do
      lst = GLib::SList.from :gint32, [3, 2, 1]
      lst2 = GLib::SList.from :gint32, lst
      assert_equal lst, lst2
    end
  end
end
