Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'urls#new'
  resources :urls, only: [:new, :create]
  get '/:url_digest', to: 'urls#show', as: 'shortened_link'
end
