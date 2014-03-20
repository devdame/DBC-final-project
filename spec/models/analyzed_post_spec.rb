require 'spec_helper'

describe AnalyzedPost do

  context "initialization" do

    let(:analyzed_post) {AnalyzedPost.create}

    it "should exist" do
      expect(analyzed_post).to be_an_instance_of AnalyzedPost
    end

    it "should be able to access its keywords" do
      keyword = Keyword.create(analyzed_post_id: analyzed_post.id)
      expect(analyzed_post.keywords.count).to eq 1
      expect(analyzed_post.keywords.first).to be_an_instance_of Keyword
    end
  end

end
