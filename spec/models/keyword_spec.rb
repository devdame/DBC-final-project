require 'spec_helper'

describe Keyword do

  context "initialization" do

    let(:keyword) {Keyword.create(analyzed_post_id: 1, text: "fun", sentiment: "positive", confidence: 0.8)}

    it "should exist" do
      expect(keyword).to be_an_instance_of Keyword
    end

     it "should be able to access its analyzed post" do
      analyzed_post = AnalyzedPost.create(school_id: 1, overall_sentiment: "neutral")
      keyword.analyzed_post = analyzed_post
      expect(keyword.analyzed_post).to eq analyzed_post
    end

  end



end
