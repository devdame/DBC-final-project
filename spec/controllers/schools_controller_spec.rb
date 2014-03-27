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
    assert_response :success
    assigns(:school).should eq(school)
  end

  it "show should have access to topics" do
    school = School.create(name: "ASU", geofeedia_id: "32204", student_body_count: 123456789)
    get :show, id: school
    assert_response :success
    assert_not_nil assigns(:topics)
  end

  it "show should have access to ratings" do
    school = School.create(name: "ASU", geofeedia_id: "32204", student_body_count: 123456789)
    get :show, id: school
    assert_response :success
    assert_not_nil assigns(:ratings)
  end

  it "show should have access to ratings profile" do
    school = School.create(name: "ASU", geofeedia_id: "32204", student_body_count: 123456789)
    rating = Rating.create(topic_id: 1, school_id: 1, total_post_count: 10_000, positive_post_count: 3_000, negative_post_count: 1_250, neutral_post_count: 1_000, mixed_post_count: 600)
    get :show, id: school
    assert_response :success
    assert_not_nil assigns(:ratings_profile)
  end

  it "schoolcompare redirects to the school index if not ajax request" do
    get :schoolcompare
    response.should redirect_to schools_url
  end
end
