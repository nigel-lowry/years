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

    specify { Years.range(2012).should == '2012' }
    specify { Years.range(2011).should == '2011–2012' }
  end
end