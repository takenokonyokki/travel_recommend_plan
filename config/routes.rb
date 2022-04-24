Rails.application.routes.draw do
  root to: 'homes#top'
  get 'homes/about'
  resources :plans, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    collection do
      get :mypage, as:'mypage'
    end
    member do
      get :favorites, as: 'favorites'
    end
    resources :contents, only: [:new, :create, :edit, :update, :destroy]
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
