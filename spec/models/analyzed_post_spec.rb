require 'spec_helper'

describe AnalyzedPost do

  let(:school) {School.create(name: "ASU", student_body_count: 52_140, first_post_time: "2014-03-21 12:14:33", most_recent_post_time: "2014-03-21 15:14:33", geofeedia_id: "12234")}
  let(:analyzed_post) {AnalyzedPost.create(school_id: school.id, overall_sentiment: "neutral", original_publish_time: "2014-03-21 16:29:33")}
  let(:topic) {Topic.create(name: "sports")}
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

  context "increment school ratings" do
    it "school rating total post count goes up by 1" do
      analyzed_post
      Keyword.create(analyzed_post_id: analyzed_post.id, text: "basketball", sentiment: "positive", confidence: 0.5)
      reference_word
      AnalyzedPost.increment_school_ratings
      expect(Rating.first.total_post_count).to eq 1
    end

    it "should not increment positive post count if confidence is low" do
      analyzed_post
      Keyword.create(analyzed_post_id: analyzed_post.id, text: "basketball", sentiment: "positive", confidence: 0.01)
      reference_word
      AnalyzedPost.increment_school_ratings
      expect(Rating.first.positive_post_count).to eq 0
    end

    it "should not increment negative post count if confidence is low" do
      analyzed_post
      Keyword.create(analyzed_post_id: analyzed_post.id, text: "basketball", sentiment: "negative", confidence: -0.01)
      reference_word
      AnalyzedPost.increment_school_ratings
      expect(Rating.first.negative_post_count).to eq 0
    end

    it "should increment mixed post count if confidence is low" do
      analyzed_post
      Keyword.create(analyzed_post_id: analyzed_post.id, text: "basketball", sentiment: "mixed", confidence: 0.01)
      reference_word
      AnalyzedPost.increment_school_ratings
      expect(Rating.first.mixed_post_count).to eq 1
    end

    it "should increment neutral post count if confidence is zero" do
      analyzed_post
      Keyword.create(analyzed_post_id: analyzed_post.id, text: "basketball", sentiment: "neutral", confidence: 0.0)
      reference_word
      AnalyzedPost.increment_school_ratings
      expect(Rating.first.neutral_post_count).to eq 1
    end

    it "should increment the positive post count for positive keywords" do
      analyzed_post
      Keyword.create(analyzed_post_id: analyzed_post.id, text: "basketball", sentiment: "positive", confidence: 0.5)
      reference_word
      AnalyzedPost.increment_school_ratings
      expect(Rating.first.positive_post_count).to eq 1
    end

    it "should not increment the positive post count for negative keywords" do
      analyzed_post
      Keyword.create(analyzed_post_id: analyzed_post.id, text: "basketball", sentiment: "negative", confidence: -0.5)
      reference_word
      AnalyzedPost.increment_school_ratings
      expect(Rating.first.positive_post_count).to eq 0
    end

    it "should not increment the positive post count for neutral keywords" do
      analyzed_post
      Keyword.create(analyzed_post_id: analyzed_post.id, text: "basketball", sentiment: "neutral", confidence: 0.0)
      reference_word
      AnalyzedPost.increment_school_ratings
      expect(Rating.first.positive_post_count).to eq 0
    end

    it "should not increment the positive post count for mixed keywords" do
      analyzed_post
      Keyword.create(analyzed_post_id: analyzed_post.id, text: "basketball", sentiment: "mixed", confidence: 0.05)
      reference_word
      AnalyzedPost.increment_school_ratings
      expect(Rating.first.positive_post_count).to eq 0
    end

    it "should increment the negative post count for negative keywords" do
      analyzed_post
      Keyword.create(analyzed_post_id: analyzed_post.id, text: "basketball", sentiment: "negative", confidence: -0.5)
      reference_word
      AnalyzedPost.increment_school_ratings
      expect(Rating.first.negative_post_count).to eq 1
    end

    it "should increment the neutral post count for neutral keywords" do
      analyzed_post
      Keyword.create(analyzed_post_id: analyzed_post.id, text: "basketball", sentiment: "neutral", confidence: 0.0)
      reference_word
      AnalyzedPost.increment_school_ratings
      expect(Rating.first.neutral_post_count).to eq 1
    end

    it "should increment the mixed post count for mixed keywords" do
      analyzed_post
      Keyword.create(analyzed_post_id: analyzed_post.id, text: "basketball", sentiment: "mixed", confidence: 0.02)
      reference_word
      AnalyzedPost.increment_school_ratings
      expect(Rating.first.mixed_post_count).to eq 1
    end

    it "should aggregate keyword sentiment and confidence and increment post counts" do
      analyzed_post
      Keyword.create(analyzed_post_id: analyzed_post.id, text: "basketball", sentiment: "positive", confidence: 0.5)
      Keyword.create(analyzed_post_id: analyzed_post.id, text: "basketball", sentiment: "positive", confidence: 0.5)
      reference_word
      AnalyzedPost.increment_school_ratings
      expect(Rating.first.positive_post_count).to eq 1
    end

    it "should not increment positive if the positive_negative_difference is insignificant" do
      analyzed_post
      Keyword.create(analyzed_post_id: analyzed_post.id, text: "basketball", sentiment: "positive", confidence: 0.51)
      Keyword.create(analyzed_post_id: analyzed_post.id, text: "basketball", sentiment: "negative", confidence: -0.50)
      reference_word
      AnalyzedPost.increment_school_ratings
      expect(Rating.first.positive_post_count).to eq 0
    end

    it "should not increment negative if the positive_negative_difference is insignificant" do
      analyzed_post
      Keyword.create(analyzed_post_id: analyzed_post.id, text: "basketball", sentiment: "positive", confidence: 0.50)
      Keyword.create(analyzed_post_id: analyzed_post.id, text: "basketball", sentiment: "negative", confidence: -0.51)
      reference_word
      AnalyzedPost.increment_school_ratings
      expect(Rating.first.negative_post_count).to eq 0
    end
  end
end
