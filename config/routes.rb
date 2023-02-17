Rails.application.routes.draw do


  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }

  devise_scope :user do
    get '/users/registrations/change_password', to: 'users/registrations#change_password'
    put '/users/registrations/:id/changed_password', to: 'users/registrations#changed_password' , as: :changed_password
  end

  root to: "homes#index"
  resources :homes do
    get :show_user, on: :member
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :sellers do
    resources :jobs do
      get 'search', on: :collection
    end
    resources :homes
  end


  namespace :buyers do
    resources :homes do
      get 'search', on: :collection
    end
    resources :checkout
  end

end
