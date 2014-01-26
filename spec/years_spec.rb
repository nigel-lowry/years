require 'spec_helper'
require 'timecop'
require 'active_support/all'
require 'years'

describe Years do

  describe ".range" do
    before do
      Timecop.freeze '26 Jan 2012'.to_date
    end

    after do
      Timecop.return
    end

    it "shows just one year if same year" do
      Years.range(2012).should == '2012'
    end
  end
end