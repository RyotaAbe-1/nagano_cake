Rails.application.routes.draw do
  devise_for :admin, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }

  devise_for :customers, skip: :all
  devise_scope :customer do
    get "/customers/sign_in" => "publics/sessions#new", as: :new_customer_session
    post "/customers/sign_in" => "publics/sessions#create", as: :customer_session
    delete "/customers/sign_out" => "publics/sessions#destroy", as: :destroy_customer_session
    get "/customers/sign_up" => "publics/registrations#new", as: :new_customer_registration
    post "/customers" => "publics/registrations#create", as: :customer_registration
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    root "homes#top"
    resources :items, except: [:destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update] do
      resources :order_details, only: [:update]
    end
  end

  scope module: :public do
    root "homes#top"
    get "/about" => "homes#about"

    resources :items, only: [:index, :show]

    get "/customers/confirm" => "customers#confirm"
    patch "/customers/withdraw" => "customers#withdraw"
    resource :customers, only: [:show, :edit, :update]

    delete "/cart_items/destroy_all" => "cart_items#destroy_all"
    resources :cart_items, only: [:index, :update, :create, :destroy]

    post "/orders/confirm" => "orders#confirm"
    get "/orders/thanks" => "orders#thanks"
    resources :orders, only: [:new, :create, :index, :show]

    resources :address, except: [:show, :new]
  end

end