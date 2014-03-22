require 'spec_helper'

describe Rating do

  let(:rating) {Rating.create(topic_id: 1, school_id: 1)}

  context "initialization" do
    it "should exist" do
      expect(rating).to be_an_instance_of Rating
    end
  end

  context "basic validations" do
    it "should belong to a school" do
      rating.school_id.should_not be_nil
    end

    it "should belong to a topic" do
      rating.topic_id.should_not be_nil
    end
  end

  context "basic associations" do
    it "should be able to access its school" do
      school = School.create(name: "UGA", student_body_count: 43_297, first_post_time: "2014-03-21 12:14:33", most_recent_post_time: "2014-03-21 15:14:33", geofeedia_id: "2985734")
      rating.school = school
      expect(rating.school).to eq school
    end

    it "should be able to access its topic" do
      topic = Topic.create(name: "Athletics")
      rating.topic = topic
      expect(rating.topic).to eq topic
    end
  end

end
