require 'years/version'

module Years
  @@EN_DASH = '–'

  def self.age_where_leapling_legal_birthday_is_28_feb date_of_birth, today=Date.current
    age date_of_birth, today, :feb28
  end

  def self.age_where_leapling_legal_birthday_is_1_mar date_of_birth, today=Date.current
    age date_of_birth, today, :mar1
  end

  def self.range first_year, last_year=Date.current.year
    raise if first_year > last_year

    (last_year == first_year) ? first_year.to_s : first_year.to_s + @@EN_DASH + last_year.to_s
  end

private

  def self.age date_of_birth, today, legal_leapling_birthday
    raise if today < date_of_birth

    years = today.year - date_of_birth.year
    (birthday(date_of_birth, years, legal_leapling_birthday) > today) ? years - 1 : years
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

end
