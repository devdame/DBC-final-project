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

end
