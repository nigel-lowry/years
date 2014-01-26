require "years/version"

module Years

  @@EN_DASH = '–'

  def self.range year
    current_year = Time.now.year

    if current_year == year
      year.to_s
    else
      year.to_s + @@EN_DASH + current_year.to_s
    end
  end
end
