Rails.application.routes.draw do
  devise_for :customers, controllers: {
    sessions:      'public/sessions',
    passwords:     'public/passwords',
    registrations: 'public/registrations'
  }
  devise_for :admin, controllers: {
    sessions:      'admin/sessions',
    passwords:     'admin/passwords',
    registrations: 'admin/registrations'
  }
  namespace :admin do
    root to: 'homes#top'
    resources :items, except: [:destroy,]
    resources :customers, only: [:index, :show, :edit, :update,]
    resources :orders, only: [:show]
  end
  scope module: :public do
   root to: 'homes#top'
   get "/about" => "homes#about", as: "about"
   patch "/customers/withdraw" => "customers#withdraw"
   get "/customers/my_page" => "customers#show"
   get "/customers/check" => "customers#check"
   delete "/cart_items/destroy_all" => "cart_items#destroy_all"
   post "/orders/confirm" => "orders#confirm"
   get "/orders/complete" => "orders#complete"
   resources :customers,only: [:edit, :update,]
   resources :items,only: [:index, :show,]
   resources :cart_items,only: [:index, :update, :create, :destroy,]
   resources :orders,only: [:new, :create, :show, :index]
  end

end