require 'rails_helper'

RSpec.describe "ShortLinks", type: :request do
  let(:random_url) { Faker::Internet.url }

  it 'creates a short link' do
    get '/short_links/new'
    expect(response).to render_template(:new)

    post '/short_links', xhr: true, params: { short_link: { long_url: random_url } }
    expect(response).to render_template(:create)
  end

  it 'redirects to the long_url with status 301' do
    short_link = ShortLink.create(long_url: random_url)

    get "/#{short_link.token}"
    expect(response).to redirect_to(short_link.long_url)
    expect(response.code).to eql('301')
  end

  it 'creates a visit record with request remote ip' do
    short_link = ShortLink.create(long_url: random_url)

    expect { get "/#{short_link.token}" }.to change { short_link.visits.count }.by 1
    expect(short_link.visits.last.ip_address).to_not be nil
  end

  it 'renders 404 not found for a non-existing token' do
    get "/#{Faker::Alphanumeric.alphanumeric(number: 5)}"
    expect(response.body).to eql('Not found.')
    expect(response.code).to eql('404')
  end

  it 'renders 404 not found if the short link has expired' do
    short_link = ShortLink.create(long_url: random_url)
    short_link.update(expiry_at: Time.now)

    get "/#{short_link.token}"
    expect(response.body).to eql('Not found.')
    expect(response.code).to eql('404')
  end
end
