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
end
