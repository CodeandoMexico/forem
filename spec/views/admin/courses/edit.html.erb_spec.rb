require 'rails_helper'

RSpec.describe "admin/courses/edit", type: :view do
  before(:each) do
    @admin_course = assign(:admin_course, Admin::Course.create!(
      name: "MyString",
      published: false,
      slug: "MyString",
      description: "MyText",
      meta_description: "MyText",
      meta_title: "MyText"
    ))
  end

  it "renders the edit admin_course form" do
    render

    assert_select "form[action=?][method=?]", admin_course_path(@admin_course), "post" do

      assert_select "input[name=?]", "admin_course[name]"

      assert_select "input[name=?]", "admin_course[published]"

      assert_select "input[name=?]", "admin_course[slug]"

      assert_select "textarea[name=?]", "admin_course[description]"

      assert_select "textarea[name=?]", "admin_course[meta_description]"

      assert_select "textarea[name=?]", "admin_course[meta_title]"
    end
  end
end
