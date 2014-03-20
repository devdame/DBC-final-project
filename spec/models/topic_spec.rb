require 'spec_helper'

describe Topic do

  context "initialization" do
    it "should exist" do
      topic = Topic.create();
      expect(topic).to be_an_instance_of Topic
    end
  end



end
