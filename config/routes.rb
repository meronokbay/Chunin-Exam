Rails.application.routes.draw do
  root to: 'home#index'
  get 'home/index'
  devise_for :users
  resources :urls, only: [:index, :new, :create, :show, :destroy]
  get '/:url_digest', to: 'urls#shortened_link', as: 'shortened_link'
end
