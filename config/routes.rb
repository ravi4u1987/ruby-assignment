Rails.application.routes.draw do
	devise_for :users
	root to: 'home#index'
	resources :secret_codes, only: [:index, :create]
end
