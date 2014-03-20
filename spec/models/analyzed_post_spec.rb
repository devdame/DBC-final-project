require 'spec_helper'

describe AnalyzedPost do

  context "initialization" do
    it "should exist" do
      analyzed_post = AnalyzedPost.create();
      expect(analyzed_post).to be_an_instance_of AnalyzedPost
    end
  end

end
