Rails.application.routes.draw do

  devise_for :admin, controllers: {
    sessions: "admin/sessions",
  }

  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions",
  }

  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  root to: 'homes#top'
  get 'about' => 'homes#about'

# ユーザー側
  scope module: :public do
    resources :users, only: [:index, :show, :edit, :update] do
      get 'user_posts' => 'posts#user_posts'
      get 'user_favorite_posts' => 'posts#user_favorite_posts'
      resource :relationships, only: [:create, :destroy]
        get "followings" => "relationships#followings", as: "followings"
        get "followers" => "relationships#followers", as: "followers"
    end
    resources :posts do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    get "search" => "searches#search"
  end

# 管理者側
  namespace :admin do
    resources :users, only: [:index, :show, :update] do
      get 'user_posts' => 'posts#user_posts'
      get 'user_favorite_posts' => 'posts#user_favorite_posts'
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
    end
    resources :posts, only: [:index, :show] do
      resources :comments, only: [:destroy]
    end
    get "search" => "searches#search"

  end

end
