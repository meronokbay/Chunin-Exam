Rails.application.routes.draw do
  root to: 'home#index'
  get 'home/index'
  devise_for :users
  resources :urls, only: [:index, :new, :create]
  get '/:url_digest', to: 'urls#show', as: 'shortened_link'
end
