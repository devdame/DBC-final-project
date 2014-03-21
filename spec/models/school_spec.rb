require 'spec_helper'

describe School do

  context "initialization" do

  let(:school) {School.create(name: "ASU")}

    it "should exist" do
      expect(school).to be_an_instance_of School
    end

    it "should be able to access its original posts" do
      original_post = OriginalPost.create(school_id: school.id, text: "post")
      expect(school.original_posts.count).to eq 1
      expect(school.original_posts.first).to be_an_instance_of OriginalPost
    end

    it "should be able to access its analyzed posts" do
      analyzed_post = AnalyzedPost.create(school_id: school.id, overall_sentiment: "positive")
      expect(school.analyzed_posts.count).to eq 1
      expect(school.analyzed_posts.first).to be_an_instance_of AnalyzedPost
    end

    it "should be able to access its ratings" do
      rating = Rating.create(school_id: school.id, topic_id: 1)
      expect(school.ratings.count).to eq 1
      expect(school.ratings.first).to be_an_instance_of Rating
    end

  end

end
