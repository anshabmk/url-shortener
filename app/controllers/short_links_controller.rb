class ShortLinksController < ApplicationController
  def new; end

  def create
    @short_link = ShortLink.new(long_url: params[:short_link][:long_url])

    respond_to do |format|
      if @short_link.save
        format.js
      else
        format.html { render action: 'new' }
      end
    end
  end

  def show
    @short_link = ShortLink.find_by_token(params[:token])

    if @short_link
      @short_link.increment!(:clicks_count)
      redirect_to @short_link.long_url, status: :moved_permanently
    else
      render plain: 'Not found.', status: :not_found
    end
  end
end
