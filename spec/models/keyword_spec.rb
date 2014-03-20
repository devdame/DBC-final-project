require 'spec_helper'

describe Keyword do

  context "initialization" do

    it "should exist" do
      keywords = Keyword.create();
      expect(keywords).to be_an_instance_of Keyword
    end

     it "should be able to access its analyzed post" do
      analyzed_post = AnalyzedPost.create
      keyword = Keyword.create(analyzed_post_id: analyzed_post.id)
      expect(keyword.analyzed_post).to eq analyzed_post
    end

  end



end
