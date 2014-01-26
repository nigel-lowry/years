require "years/version"

module Years

  @@EN_DASH = '–'

  def self.range first_year, last_year=Time.now.year
    raise if first_year > last_year

    (last_year == first_year) ? first_year.to_s : first_year.to_s + @@EN_DASH + last_year.to_s
  end
end
