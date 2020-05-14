class StatsController < ApplicationController
  PAGE_START = '1'
  PER_PAGE = '5'

  def index
    @page = (params[:page] || PAGE_START).to_i
    @per_page = (params[:per_page] || PER_PAGE).to_i
    @total_count = ShortLink.count
    @offset = @per_page * (@page - 1)

    @short_links = ShortLink.order(created_at: :desc)
                            .offset(@offset)
                            .limit(@per_page)
  end
end
