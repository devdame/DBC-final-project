require 'spec_helper'

describe Rating do

  let(:rating) {Rating.create(topic_id: 1, school_id: 1)}

  context "initialization" do
    it "should exist" do
      expect(rating).to be_an_instance_of Rating
    end

    it "should be able to access its school" do
      school = School.create(name: "MSU")
      rating.school = school
      expect(rating.school).to eq school
    end

    it "should be able to access its topic" do
      topic = Topic.create(name: "Athletics")
      rating.topic = topic
      expect(rating.topic).to eq topic
    end

  end

end
