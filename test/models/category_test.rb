require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup
    @category = Category.new(name: "sports")
  end

  test "category should be valid" do
    assert @category.valid?
  end

  test "name should be present" do
    @category.name = " "
    assert_not @category.valid?
  end

  test "name should be unique" do
    @category.save
    second_category = Category.new(name: "sports")
    assert_not second_category.valid?
  end

  test "name should not be to long" do
    @category.name = "a" * 36
    assert_not @category.valid?
  end

  test "name should not be to short" do
    @category.name = "aa"
    assert_not @category.valid?
  end

end
