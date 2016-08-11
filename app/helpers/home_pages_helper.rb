module HomePagesHelper

  #Humanize category in the url
  #/category/ILoveYou instead of
  # /category/I20%Love20%You
  def humanize_url(category)
    case category
      when "ILoveYou"
        "I Love You"
      when "LongDistance"
        "Long Distance"
      else
        "Missing You"
    end
  end
end
