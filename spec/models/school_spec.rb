require 'spec_helper'

describe School do

  let(:school) {School.create(name: "ASU", student_body_count: 52_140, first_post_time: "2014-03-21 12:14:33", most_recent_post_time: "2014-03-21 15:14:33", geofeedia_id: "12234")}

  context "initialization" do
    it "should exist" do
      expect(school).to be_an_instance_of School
    end
  end

  context "basic validations" do
    it "should have a name" do
      school.name.should_not be_nil
    end

    it "should have a student body count" do
      school.student_body_count.should_not be_nil
    end

    it "should have a geofeedia id" do
      school.geofeedia_id.should_not be_nil
    end
  end

  context "basic associations" do
    it "should be able to access its original posts" do
      original_post = OriginalPost.create(school_id: school.id, text: "post", geofeedia_school_id: "123456", original_publish_time: "2014-03-21 15:14:33")
      expect(school.original_posts.count).to eq 1
      expect(school.original_posts.first).to be_an_instance_of OriginalPost
    end

    it "should be able to access its analyzed posts" do
      analyzed_post = AnalyzedPost.create(school_id: school.id, overall_sentiment: "positive", original_publish_time: "2014-03-21 15:14:33")
      expect(school.analyzed_posts.count).to eq 1
      expect(school.analyzed_posts.first).to be_an_instance_of AnalyzedPost
    end

    it "should be able to access its ratings" do
      rating = Rating.create(school_id: school.id, topic_id: 1)
      expect(school.ratings.count).to eq 1
      expect(school.ratings.first).to be_an_instance_of Rating
    end
  end


  context "activity ratio methods" do
    let(:school) {School.create(name: "ASU", student_body_count: 50_000, first_post_time: "2014-03-21 12:14:33", most_recent_post_time: "2014-03-21 15:14:33", geofeedia_id: "12234", post_count: 12_500, positive_post_count: 3_000, negative_post_count: 1_250, neutral_post_count: 500, mixed_post_count: 750)}

    it "should calculate the relative social media activity of a school" do
      expect(school.social_media_activity).to eq 0.25
    end

    it "should calculate the positive vibe ratio of the school" do
      expect(school.positive_vibe_ratio).to eq 0.24
    end

    it "should calculate the negative vibe ratio of the school" do
      expect(school.negative_vibe_ratio).to eq 0.1
    end

    it "should calculate the neutral vibe ratio of the school" do
      expect(school.neutral_vibe_ratio).to eq 0.04
    end

    it "should calculate the mixed vibe ratio of the school" do
      expect(school.mixed_vibe_ratio).to eq 0.06
    end
  end
end
