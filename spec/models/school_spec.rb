require 'spec_helper'

describe School do

  context "initialization" do
    it "should exist" do
      school = School.create();
      expect(school).to be_an_instance_of School
    end
  end



end
