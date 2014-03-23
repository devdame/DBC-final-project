require 'spec_helper'

describe SchoolsController, :type => :request do

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

  it "assigns the requested school to @school" do
    school = School.create(name: "ASU", geofeedia_id: "32204", student_body_count: 123456789)
    get :show, id: school
    assigns(:school).should eq(school)
  end
end
