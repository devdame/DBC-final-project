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



  context "activity ratio methods" do
    let(:rating) {Rating.create(topic_id: 1, school_id: 1, total_post_count: 10_000, positive_post_count: 3_000, negative_post_count: 1_250, neutral_post_count: 1_000, mixed_post_count: 600)}

    it "should calculate how much the topic is talked about in relation to total posts at school" do
      school = School.create(name: "UGA", student_body_count: 43_297, post_count: 50_000, first_post_time: "2014-03-21 12:14:33", most_recent_post_time: "2014-03-21 15:14:33", geofeedia_id: "2985734")
      rating.school = school
      expect(rating.topic_activity_ratio).to eq 0.2
    end

    it "should calculate the pos/total sentiment ratio of this topic at this school" do
      expect(rating.topic_positivity_ratio).to eq 0.3
    end

    it "should calculate the neg/total sentiment ratio of this topic at this school" do
      expect(rating.topic_negativity_ratio).to eq 0.125
    end

    it "should calculate the neutral/total sentiment ratio of this topic at this school" do
      expect(rating.topic_neutral_ratio).to eq 0.1
    end

    it "should calculate the mixed/total sentiment ratio of this topic at this school" do
      expect(rating.topic_mixed_ratio).to eq 0.06
    end

  end
end
