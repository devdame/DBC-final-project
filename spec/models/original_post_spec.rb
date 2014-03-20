require 'spec_helper'

describe OriginalPost do

  context "initialization" do
    it "should exist" do
      original_post = OriginalPost.create();
      expect(original_post).to be_an_instance_of OriginalPost
    end
  end



end
