module StatsHelper
  def top_countries(short_link)
    short_link.top_countries_with_count(3).keys.join(', ')
  end
end
