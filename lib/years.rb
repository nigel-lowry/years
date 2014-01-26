require 'years/version'

module Years

  @@EN_DASH = '–'

  def self.age date_of_birth
    now = Date.current
    years = now.year - date_of_birth.year

    if february_29th? date_of_birth
      if date_of_birth.years_since(years).tomorrow > now
        years - 1
      else
        years
      end
    else
      if date_of_birth.years_since(years) > now
        years - 1
      else
        years
      end
    end
  end

  def self.range first_year, last_year=Date.current.year
    raise if first_year > last_year

    (last_year == first_year) ? first_year.to_s : first_year.to_s + @@EN_DASH + last_year.to_s
  end

private

  def self.february_29th? date
    date.mday == 29 and date.mon == 2
  end

end
