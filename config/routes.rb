Rails.application.routes.draw do
  root to: 'urls#new'
  devise_for :users
  resources :urls, only: [:new, :create]
  get '/:url_digest', to: 'urls#show', as: 'shortened_link'
end
