require 'spec_helper'

describe OriginalPost do

  context "initialization" do

    let(:school) {School.create(name: "school")}
    let(:original_post) {OriginalPost.create(school_id: school.id, text: "blah")}


    it "should exist" do
      expect(original_post).to be_an_instance_of OriginalPost
    end

    it "should be able to access its school" do
      expect(original_post.school).to eq school
    end

  end

end
