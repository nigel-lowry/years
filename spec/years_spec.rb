require 'spec_helper'
require 'timecop'
require 'active_support/all'
require 'years'

describe Years do
  describe '.age_where_leapling_legal_birthday_is_1_mar' do
    context 'regular birthday' do
      let(:date_of_birth) { '22 Sep 1976'.to_date }

      it 'raises error if not born yet' do
        expect { Years.age_where_leapling_legal_birthday_is_1_mar(date_of_birth, '21 Sep 1976'.to_date) }.to raise_error
      end

      specify { expect(Years.age_where_leapling_legal_birthday_is_1_mar date_of_birth, '22 Sep 1976'.to_date).to eq 0 }
      specify { expect(Years.age_where_leapling_legal_birthday_is_1_mar date_of_birth, '23 Sep 1976'.to_date).to eq 0 }

      specify { expect(Years.age_where_leapling_legal_birthday_is_1_mar date_of_birth, '21 Sep 1977'.to_date).to eq 0 }
      specify { expect(Years.age_where_leapling_legal_birthday_is_1_mar date_of_birth, '22 Sep 1977'.to_date).to eq 1 }
      specify { expect(Years.age_where_leapling_legal_birthday_is_1_mar date_of_birth, '23 Sep 1977'.to_date).to eq 1 }

      specify { expect(Years.age_where_leapling_legal_birthday_is_1_mar date_of_birth, '21 Sep 1978'.to_date).to eq 1 }
      specify { expect(Years.age_where_leapling_legal_birthday_is_1_mar date_of_birth, '22 Sep 1978'.to_date).to eq 2 }
      specify { expect(Years.age_where_leapling_legal_birthday_is_1_mar date_of_birth, '23 Sep 1978'.to_date).to eq 2 }

      it 'uses current date when second argument missing' do
        Timecop.freeze '22 Sep 2006'.to_date do
          expect(Years.age_where_leapling_legal_birthday_is_1_mar date_of_birth).to eq 30
        end
      end
    end

    context 'leap year birthday' do
      let(:date_of_birth) { '29 Feb 2004'.to_date }

      specify { expect(Years.age_where_leapling_legal_birthday_is_1_mar date_of_birth, '1 Mar 2004'.to_date).to eq 0 }
      specify { expect(Years.age_where_leapling_legal_birthday_is_1_mar date_of_birth, '28 Feb 2005'.to_date).to eq 0 }
      specify { expect(Years.age_where_leapling_legal_birthday_is_1_mar date_of_birth, '1 Mar 2005'.to_date).to eq 1 }
    end
  end

  describe '.age_where_leapling_legal_birthday_is_28_feb' do
    let(:date_of_birth) { '29 Feb 2004'.to_date }
    specify { expect(Years.age_where_leapling_legal_birthday_is_28_feb date_of_birth, '28 Feb 2005'.to_date).to eq 1 }
  end

  describe '.range' do
    before do
      Timecop.freeze '26 Jan 2012'.to_date
    end

    after do
      Timecop.return
    end

    specify { expect(Years.range 2010).to eq '2010–2012' }
    specify { expect(Years.range 2011).to eq '2011–2012' }
    specify { expect(Years.range 2012).to eq '2012' }

    it 'raises error if only year is float' do
      expect { Years.range(2013.1) }.to raise_error
    end

    it 'raises error if first year is float' do
      expect { Years.range(2013.1, 2014) }.to raise_error
    end

    it 'raises error if second year is float' do
      expect { Years.range(2012, 2013.1) }.to raise_error
    end

    it 'raises error if both years are floats' do
      expect { Years.range(2013.1, 2014.2) }.to raise_error
    end

    it 'raises error if only year is negative' do
      expect { Years.range(-1) }.to raise_error
    end

    it 'raises error if first year is negative' do
      expect { Years.range(-1, 0) }.to raise_error
    end

    it 'raises error if second year is float' do
      expect { Years.range(0, -1) }.to raise_error
    end

    it 'raises error if both years are negative' do
      expect { Years.range(-2, -1) }.to raise_error
    end

    it 'raises error if range would be in future' do
      expect { Years.range(2013) }.to raise_error
    end

    specify { expect(Years.range 2011, 2011).to eq '2011' }
    specify { expect(Years.range 0, 1).to eq '0–1' }
    specify { expect(Years.range 2011, 2012).to eq '2011–2012' }
    specify { expect(Years.range 2011, 2013).to eq '2011–2013' }
    specify { expect(Years.range 2011, 2014).to eq '2011–2014' }

    it 'raises error if range is wrong way round' do
      expect { Years.range(2013, 2011) }.to raise_error
    end
  end
end