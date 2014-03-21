require 'spec_helper'

describe AnalyzedPost do

  context "initialization" do

    let(:analyzed_post) {AnalyzedPost.create(school_id: 1, overall_sentiment: "neutral", geofeedia_school_id: "987345", original_publish_time: "2014-03-21 16:29:33")}

    it "should exist" do
      expect(analyzed_post).to be_an_instance_of AnalyzedPost
    end

    it "should be able to access its keywords" do
      keyword = Keyword.create(analyzed_post_id: analyzed_post.id, text: "fun", sentiment: "positive", confidence: 0.8)
      expect(analyzed_post.keywords.count).to eq 1
      expect(analyzed_post.keywords.first).to be_an_instance_of Keyword
    end
  end

end
