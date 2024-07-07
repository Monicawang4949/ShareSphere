Rails.application.routes.draw do

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
    resources :users, only: [:index, :show, :edit,:update]
  end

end
