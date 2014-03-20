require 'spec_helper'

describe OriginalPost do

  context "initialization" do

    it "should exist" do
      original_post = OriginalPost.create();
      expect(original_post).to be_an_instance_of OriginalPost
    end

    it "should be able to access its school" do
      school = School.create
      post = OriginalPost.create(school_id: school.id)
      expect(post.school).to eq school
    end

  end

end
