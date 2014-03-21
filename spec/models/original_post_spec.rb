require 'spec_helper'

describe OriginalPost do

  context "initialization" do

    let(:school) {School.create(name: "school", most_recent_post_time: "2014-03-21 15:14:33")}
    let(:original_post) {OriginalPost.create(school_id: school.id, text: "blah", geofeedia_school_id: "123456", original_publish_time: "2014-03-21 15:14:33")}


    it "should exist" do
      expect(original_post).to be_an_instance_of OriginalPost
    end

    it "should be able to access its school" do
      expect(original_post.school).to eq school
    end

  end

end
