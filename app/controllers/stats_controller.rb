class StatsController < ApplicationController
  def index
    @short_links = ShortLink.order(created_at: :desc)
  end
end
