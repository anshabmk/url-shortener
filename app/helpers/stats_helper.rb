module StatsHelper
  def top_countries(short_link)
    short_link.top_countries_with_count(3).keys.join(', ')
  end

  def previous_page
    return unless @page > 1

    @page - 1
  end

  def next_page
    return unless (@total_count / @per_page.to_f) > @page

    @page + 1
  end
end
