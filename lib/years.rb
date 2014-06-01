require 'years/version'

# Provides some year-related methods.
module Years
  @@EN_DASH = '–'

  # tells the age of someone, with truncation, where the leapling legal birthday is 28 February
  # @param [Date] date_of_birth the person's date of birth
  # @param [Date] today the day that you want to know their date of birth for, defaults to today
  # @return [Fixnum]
  def self.age_where_leapling_legal_birthday_is_28_feb date_of_birth, today=Date.current
    age date_of_birth, today, :feb28
  end

  # tells the age of someone, with truncation, where the leapling legal birthday is 1 March
  # @param (see Years.age_where_leapling_legal_birthday_is_28_feb)
  # @param (see Years.age_where_leapling_legal_birthday_is_28_feb)
  # @return (see Years.age_where_leapling_legal_birthday_is_28_feb)
  def self.age_where_leapling_legal_birthday_is_1_mar date_of_birth, today=Date.current
    age date_of_birth, today, :mar1
  end

  # tells the age of someone, with truncation, where the leapling legal birthday is 28 February
  # @param [Fixnum] first_year the first year of the range, say the year of company creation
  # @param [Fixnum] last_year the last year of the range, defaults to this year
  # @return [String]
  def self.range first_year, last_year=Date.current.year
    raise if out_of_sequence? first_year, last_year
    raise if any_negative? first_year, last_year
    raise unless all_fixnum? first_year, last_year

    (first_year == last_year) ? first_year.to_s : "#{first_year}#{@@EN_DASH}#{last_year}"
  end

private

  def self.age date_of_birth, today, legal_leapling_birthday
    raise unless born_yet? date_of_birth, today

    years = today.year - date_of_birth.year
    (birthday(date_of_birth, years, legal_leapling_birthday) > today) ? years - 1 : years
  end

  def self.born_yet? date_of_birth, today
    today >= date_of_birth
  end

  def self.birthday date_of_birth, years, legal_leapling_birthday
    bday = date_of_birth.years_since years
    (leapling?(date_of_birth) and legal_leapling_birthday == :mar1) ? bday.tomorrow : bday
  end

  def self.leapling? date
    february_29th? date
  end

  def self.february_29th? date
    date.mday == 29 and date.mon == 2
  end

  def self.out_of_sequence? first_year, last_year
    first_year > last_year
  end

  def self.any_negative? first_year, last_year
    [first_year, last_year].any? { |year| year < 0 }
  end

  def self.all_fixnum? first_year, last_year
    [first_year, last_year].all? { |year| year.is_a? Fixnum }
  end

end
