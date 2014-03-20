require 'spec_helper'

describe ReferenceWord do

  context "initialization" do
    it "should exist" do
      reference_word = ReferenceWord.create();
      expect(reference_word).to be_an_instance_of ReferenceWord
    end
  end



end
