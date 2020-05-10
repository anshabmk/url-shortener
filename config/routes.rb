Rails.application.routes.draw do
  resources :short_links, only: %i[new create]

  get '/:token', to: 'short_links#show', as: 'short_link'
end
