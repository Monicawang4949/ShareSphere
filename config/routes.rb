Rails.application.routes.draw do

  namespace :admin do
    get 'posts/index'
    get 'posts/show'
  end
  namespace :admin do
    get 'users/index'
    get 'users/show'
    get 'users/edit'
  end
  devise_for :admin, controllers: {
    sessions: "admin/sessions",
  }

  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions",
  }

  root to: 'homes#top'
  get 'about' => 'homes#about'

  scope module: :public do
    resources :users, only: [:index, :show, :edit, :update] do
      get 'user_posts' => 'posts#user_posts'

      collection do
        get 'search'
      end
    end
    resources :posts
    get "search" => "searches#search"
  end

  namespace :admin do
    resources :users, only: [:index, :show, :update] do
      get 'user_posts' => 'posts#user_posts'
    end
    resources :posts, only: [:index, :show]
    get "search" => "searches#search"
  end

end
