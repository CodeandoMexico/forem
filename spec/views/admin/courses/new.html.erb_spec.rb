require 'rails_helper'

RSpec.describe "admin/courses/new", type: :view do
  before(:each) do
    assign(:admin_course, Admin::Course.new(
      name: "MyString",
      published: false,
      slug: "MyString",
      description: "MyText",
      meta_description: "MyText",
      meta_title: "MyText"
    ))
  end

  it "renders new admin_course form" do
    render

    assert_select "form[action=?][method=?]", admin_courses_path, "post" do

      assert_select "input[name=?]", "admin_course[name]"

      assert_select "input[name=?]", "admin_course[published]"

      assert_select "input[name=?]", "admin_course[slug]"

      assert_select "textarea[name=?]", "admin_course[description]"

      assert_select "textarea[name=?]", "admin_course[meta_description]"

      assert_select "textarea[name=?]", "admin_course[meta_title]"
    end
  end
end
