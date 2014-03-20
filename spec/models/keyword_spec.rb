require 'spec_helper'

describe Keyword do

  context "initialization" do
    it "should exist" do
      keywords = Keyword.create();
      expect(keywords).to be_an_instance_of Keyword
    end
  end



end
