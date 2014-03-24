require 'spec_helper'

describe Keyword do

  let(:keyword) {Keyword.create(analyzed_post_id: 1, text: "fun", sentiment: "positive", confidence: 0.8)}


  context "initialization" do
    it "should exist" do
      expect(keyword).to be_an_instance_of Keyword
    end
  end

  context "basic validations" do
    it "should belong to an analyzed post" do
      keyword.analyzed_post_id.should_not be_nil
    end

    it "should have text" do
      keyword.text.should_not be_nil
    end

    it "should have a sentiment" do
      keyword.sentiment.should_not be_nil
    end

    it "should have a confidence value" do
      keyword.sentiment.should_not be_nil
    end
  end

  context "basic associations" do
    it "should be able to access its analyzed post" do
      analyzed_post = AnalyzedPost.create(school_id: 1, overall_sentiment: "neutral", original_publish_time: "2014-03-21 15:14:33")
      keyword.analyzed_post = analyzed_post
      expect(keyword.analyzed_post).to eq analyzed_post
    end
  end
##################################################################################
    let(:reference_word) {ReferenceWord.create(topic_id: 1, name: "fun")}
    let(:analyzed_post) {AnalyzedPost.create(id: 1, school_id: 1, overall_sentiment: "positive", original_publish_time: "2014-03-21 16:29:33")}
    # let(:school_word_count) {SchoolWordCount.first}

  context "create or update school word counts" do
    it "should have access to all the reference word texts" do
      reference_word
      Keyword.populate_reference_words
      expect(Keyword.reference_words.first).to eq ReferenceWord.first.canonical_name
    end

    it "should increment the total school word count" do
      keyword
      reference_word
      Keyword.populate_reference_words
      analyzed_post
      Keyword.create_or_update_school_word_counts
      expect(reference_word.school_word_counts.first.word_count).to eq 1
    end

    it "should increment the positive word count on school word count for positive words" do
      keyword
      reference_word
      Keyword.populate_reference_words
      analyzed_post
      Keyword.create_or_update_school_word_counts
      expect(reference_word.school_word_counts.first.positive_word_count).to eq 1
    end

    it "should increment the negative word count on school word count for negative words" do
      Keyword.create(analyzed_post_id: 1, text: "fun", sentiment: "negative", confidence: -0.8)
      reference_word
      Keyword.populate_reference_words
      analyzed_post
      Keyword.create_or_update_school_word_counts
      expect(reference_word.school_word_counts.first.negative_word_count).to eq 1
    end

    it "should increment the mixed word count on school word count when confidence is low" do
      Keyword.create(analyzed_post_id: 1, text: "fun", sentiment: "mixed", confidence: 0.01)
      reference_word
      Keyword.populate_reference_words
      analyzed_post
      Keyword.create_or_update_school_word_counts
      expect(reference_word.school_word_counts.first.mixed_word_count).to eq 1
    end

    it "should increment the neutral word count on school word count when confidence is zero" do
      Keyword.create(analyzed_post_id: 1, text: "fun", sentiment: "mixed", confidence: 0.0)
      reference_word
      Keyword.populate_reference_words
      analyzed_post
      Keyword.create_or_update_school_word_counts
      expect(reference_word.school_word_counts.first.neutral_word_count).to eq 1
    end
  end
end
