require 'rails_helper'

RSpec.describe "admin/courses/index", type: :view do
  before(:each) do
    assign(:admin_courses, [
      Admin::Course.create!(
        name: "Name",
        published: false,
        slug: "Slug",
        description: "MyText",
        meta_description: "MyText",
        meta_title: "MyText"
      ),
      Admin::Course.create!(
        name: "Name",
        published: false,
        slug: "Slug",
        description: "MyText",
        meta_description: "MyText",
        meta_title: "MyText"
      )
    ])
  end

  it "renders a list of admin/courses" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
    assert_select "tr>td", text: "Slug".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
  end
end
