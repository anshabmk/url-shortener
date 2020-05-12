Rails.application.routes.draw do
  root 'short_links#new'

  resources :short_links, only: %i[new create]
  resources :stats, only: %i[index]

  get '/:token', to: 'short_links#show', as: 'short_link'
end
