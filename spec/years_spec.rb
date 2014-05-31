require 'spec_helper'
require 'timecop'
require 'active_support/all'
require 'years'

describe Years do
  describe ".age_where_leapling_legal_birthday_is_1_mar" do
    context "regular birthday" do
      let(:date_of_birth) { '22 Sep 1976'.to_date }

      it "raises error if not born yet" do
        expect { Years.age_where_leapling_legal_birthday_is_1_mar(date_of_birth, '21 Sep 1976'.to_date) }.to raise_error
      end

      specify { expect(Years.age_where_leapling_legal_birthday_is_1_mar date_of_birth, '22 Sep 1976'.to_date).to eq 0 }
      specify { expect(Years.age_where_leapling_legal_birthday_is_1_mar date_of_birth, '23 Sep 1976'.to_date).to eq 0 }

      specify { Years.age_where_leapling_legal_birthday_is_1_mar(date_of_birth, '21 Sep 1977'.to_date).should == 0 }
      specify { Years.age_where_leapling_legal_birthday_is_1_mar(date_of_birth, '22 Sep 1977'.to_date).should == 1 }
      specify { Years.age_where_leapling_legal_birthday_is_1_mar(date_of_birth, '23 Sep 1977'.to_date).should == 1 }

      specify { Years.age_where_leapling_legal_birthday_is_1_mar(date_of_birth, '21 Sep 1978'.to_date).should == 1 }
      specify { Years.age_where_leapling_legal_birthday_is_1_mar(date_of_birth, '22 Sep 1978'.to_date).should == 2 }
      specify { Years.age_where_leapling_legal_birthday_is_1_mar(date_of_birth, '23 Sep 1978'.to_date).should == 2 }

      it "uses current date when second argument missing" do
        Timecop.freeze '22 Sep 2006'.to_date do
          Years.age_where_leapling_legal_birthday_is_1_mar(date_of_birth).should == 30
        end
      end
    end

    context "leap year birthday" do
      let(:date_of_birth) { '29 Feb 2004'.to_date }

      specify { Years.age_where_leapling_legal_birthday_is_1_mar(date_of_birth, '1 Mar 2004'.to_date).should == 0 }
      specify { Years.age_where_leapling_legal_birthday_is_1_mar(date_of_birth, '28 Feb 2005'.to_date).should == 0 }
      specify { Years.age_where_leapling_legal_birthday_is_1_mar(date_of_birth, '1 Mar 2005'.to_date).should == 1 }
    end
  end

  describe ".age_where_leapling_legal_birthday_is_28_feb" do
    let(:date_of_birth) { '29 Feb 2004'.to_date }
    specify { Years.age_where_leapling_legal_birthday_is_28_feb(date_of_birth, '28 Feb 2005'.to_date).should == 1 }
  end

  describe ".range" do
    before do
      Timecop.freeze '26 Jan 2012'.to_date
    end

    after do
      Timecop.return
    end

    specify { Years.range(2010).should == '2010–2012' }
    specify { Years.range(2011).should == '2011–2012' }
    specify { Years.range(2012).should == '2012' }

    it "raises error if range would be in future" do
      expect { Years.range(2013) }.to raise_error
    end

    specify { Years.range(2011, 2011).should == '2011' }
    specify { Years.range(2011, 2012).should == '2011–2012' }
    specify { Years.range(2011, 2013).should == '2011–2013' }
    specify { Years.range(2011, 2014).should == '2011–2014' }

    it "raises error if range is wrong way round" do
      expect { Years.range(2013, 2011) }.to raise_error
    end
  end
end