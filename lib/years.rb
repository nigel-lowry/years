require 'years/version'

module Years
  @@EN_DASH = '–'

  def self.age date_of_birth, now=Date.current
    raise if now < date_of_birth

    years = now.year - date_of_birth.year
    (birthday(date_of_birth, years) > now) ? years - 1 : years
  end

  def self.range first_year, last_year=Date.current.year
    raise if first_year > last_year

    (last_year == first_year) ? first_year.to_s : first_year.to_s + @@EN_DASH + last_year.to_s
  end

private

  def self.birthday date_of_birth, years
    bday = date_of_birth.years_since years

    if february_29th? date_of_birth
      bday.tomorrow
    else
      bday
    end
  end

  def self.february_29th? date
    date.mday == 29 and date.mon == 2
  end

end
