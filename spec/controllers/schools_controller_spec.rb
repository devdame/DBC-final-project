require 'spec_helper'

describe SchoolsController do
  it "index should have access to schools" do
    get :index
    assert_response :success
    assert_not_nil assigns(:schools)
  end

  it "index should have access to topics" do
    get :index
    assert_response :success
    assert_not_nil assigns(:topics)
  end

  xit "can visit a school show page by clicking the title" do
    school = School.create(name: "SampleShit", geofeedia_id: "32211", student_body_count: 123456789)
    visit "/schools"
    click_link("SampleShit")
    current_path.should eq "/schools/1"
  end
end
