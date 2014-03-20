require 'spec_helper'

describe Rating do

  context "initialization" do
    it "should exist" do
      rating = Rating.create();
      expect(rating).to be_an_instance_of Rating
    end
  end



end
