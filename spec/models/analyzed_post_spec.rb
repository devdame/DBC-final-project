require 'spec_helper'

describe AnalyzedPost do

  let(:school) {School.create(name: "ASU", student_body_count: 52_140, first_post_time: "2014-03-21 12:14:33", most_recent_post_time: "2014-03-21 15:14:33", geofeedia_id: "12234")}
  let(:analyzed_post) {AnalyzedPost.create(school_id: school.id, overall_sentiment: "neutral", original_publish_time: "2014-03-21 16:29:33")}
  let(:keyword) {Keyword.create(analyzed_post_id: analyzed_post.id, text: "test", sentiment: "positive", confidence: 0.5)}
  let(:topic) {Topic.create(name: sports)}
  let(:reference_word) {ReferenceWord.create(topic_id: topic.id, name: "basketball")}

  context "initialization" do
    it "should exist" do
      expect(analyzed_post).to be_an_instance_of AnalyzedPost
    end
  end

  context "basic validations" do
    it "should belong to a school" do
      analyzed_post.school_id.should_not be_nil
    end

    it "should have an overall sentiment" do
      analyzed_post.overall_sentiment.should_not be_nil
    end

    it "should have an original publish time" do
      analyzed_post.original_publish_time.should_not be_nil
    end
  end

  context "basic associations" do
    it "should be able to access its school" do
      expect(analyzed_post.school).to eq school
    end

    it "should be able to access its keywords" do
      keyword = Keyword.create(analyzed_post_id: analyzed_post.id, text: "fun", sentiment: "positive", confidence: 0.8)
      expect(analyzed_post.keywords.count).to eq 1
      expect(analyzed_post.keywords.first).to be_an_instance_of Keyword
    end
  end

  before(:each) do
    AnalyzedPost.create(school_id: school.id, overall_sentiment: "positive", original_publish_time: "2014-03-21 16:29:33")
    AnalyzedPost.create(school_id: school.id, overall_sentiment: "negative", original_publish_time: "2014-03-21 16:29:33")
    AnalyzedPost.create(school_id: school.id, overall_sentiment: "neutral", original_publish_time: "2014-03-21 16:29:33")
    AnalyzedPost.create(school_id: school.id, overall_sentiment: "mixed", original_publish_time: "2014-03-21 16:29:33")
    AnalyzedPost.increment_school_word_count
  end


  context "increments school post count" do
    it "should add to the school post count" do
      expect(School.first.post_count).to eq 4
    end
  end

  context "incrementing school post count" do
    it "should add to the school post count" do
      expect(School.first.positive_post_count).to eq 1
    end
  end

  context "incrementing school post count" do
    it "should add to the school post count" do
      expect(School.first.negative_post_count).to eq 1
    end
  end

  context "incrementing school post count" do
    it "should add to the school post count" do
      expect(School.first.neutral_post_count).to eq 1
    end
  end

  context "incrementing school post count" do
    it "should add to the school post count" do
      expect(School.first.mixed_post_count).to eq 1
    end
  end
end
