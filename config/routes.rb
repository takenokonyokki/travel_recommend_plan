Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  root to: 'homes#top'
  get 'homes/about'
  resources :plans, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resources :contents, only: [:new, :create, :edit, :update, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
