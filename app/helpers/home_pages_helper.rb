module HomePagesHelper

  #Humanize category in the url
  #/category/ILoveYou instead of
  # /category/I20%Love20%You
  def humanize_url(category)
    case category
      when "ThankYou"
        "Thank You"
    end
  end
end
