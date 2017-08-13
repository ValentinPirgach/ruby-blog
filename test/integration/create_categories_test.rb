require "test_helper"

class CreateCategoriesTest < ActionDispatch::IntegrationTest

  test "when get new category form and create category" do

    get new_category_path
    assert_template :new
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: {name: "sports"} }
      follow_redirect!
    end

    assert_template 'categories/index'
    assert_match "sports", response.body
  end

  test "when invalid category submission result in failure" do

    get new_category_path
    assert_template :new

    post categories_path, params: { category: {name: ""} }

    assert_template :new
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end
