require "years/version"

module Years

  @@EN_DASH = '–'

  def self.range first_year
    current_year = Time.now.year

    if current_year == first_year
      first_year.to_s
    else
      first_year.to_s + @@EN_DASH + current_year.to_s
    end
  end
end
