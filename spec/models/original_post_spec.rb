require 'spec_helper'

describe OriginalPost do

  let(:school) {School.create(name: "UGA", student_body_count: 33_297, first_post_time: "2014-03-21 12:14:33", most_recent_post_time: "2014-03-21 15:14:33", geofeedia_id: "298734")}
  let(:original_post) {OriginalPost.create(school_id: school.id, text: "fun fun", geofeedia_school_id: "123456", original_publish_time: "2014-03-21 15:14:33", external_id: "9877378")}

  context "initialization" do
    it "should exist" do
      expect(original_post).to be_an_instance_of OriginalPost
    end
  end

  context "basic validations" do
    it "should belong to a school" do
      original_post.school_id.should_not be_nil
    end

    it "should have a text" do
      original_post.text.should_not be_nil
    end

    it "should have a geofeedia school id" do
      original_post.geofeedia_school_id.should_not be_nil
    end

    it "should have an original publish time" do
      original_post.original_publish_time.should_not be_nil
    end
  end

  context "basic associations" do
    it "should be able to access its school" do
      expect(original_post.school).to eq school
    end
  end

end
