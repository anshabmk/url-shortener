Rails.application.routes.draw do
  resources :short_links, only: %i[new create show]
end
