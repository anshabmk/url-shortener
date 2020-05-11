require 'rails_helper'

RSpec.describe "ShortLinks", type: :request do
  it 'creates a short link' do
    get '/short_links/new'
    expect(response).to render_template(:new)

    post '/short_links', xhr: true, params: { short_link: { long_url: Faker::Internet.url } }
    expect(response).to render_template(:create)
  end
end
