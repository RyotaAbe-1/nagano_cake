Rails.application.routes.draw do
  devise_for :admins
  devise_for :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

<<<<<<< HEAD
=======

>>>>>>> 34e53e938416793a4290b601e9e85716d8ae1c76
  namespace :admin do
    get "/" => "homes#top", as: :root
    resources :items, except: [:destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update] do
      resources :order_details, only: [:update]
    end
  end
<<<<<<< HEAD
  
=======
>>>>>>> 34e53e938416793a4290b601e9e85716d8ae1c76
end
