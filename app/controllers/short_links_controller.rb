class ShortLinksController < ApplicationController
  def new; end

  def create
    @short_link = ShortLink.create(long_url: params[:short_link][:long_url])

    respond_to { |format| format.js }
  end

  def show
    @short_link = ShortLink.find_by_token(params[:token])

    if @short_link and @short_link.expiry_at.future?
      @short_link.visits.create(ip_address: request.remote_ip)

      redirect_to @short_link.long_url, status: :moved_permanently
    else
      render plain: 'Not found.', status: :not_found
    end
  end
end
