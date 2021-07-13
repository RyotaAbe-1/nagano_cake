Rails.application.routes.draw do
  devise_for :admin, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  devise_for :customers, controllers: {
    sessions:     'customers/sessions',
    passwords:     'customers/passwords',
    registrations: 'customers/registrations'
  }
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
    resource :customers, only: [:show, :edit, :update]
    get "/customers/confirm" => "customers#confirm"
    patch "/customers/withdraw" => "customers#withdraw"
    delete "/cart_items/destroy_all" => "cart_items#destroy_all"
    resources :cart_items, only: [:index, :update, :create, :destroy]
    resources :orders, only: [:new, :create, :index, :show]
    post "/orders/confirm" => "orders#confirm"
    get "/orders/thanks" => "orders#thanks"
    resources :address, except: [:show, :new]
  end

end