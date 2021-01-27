Rails.application.routes.draw do
    root 'chatrooms#index'
    get 'login', to: 'sessions#new'
    resources :users, except: [:new]
    get 'signup', to: 'users#new'
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    resources :chatrooms , except: [:index]
    delete 'logout', to: 'sessions#destroy'
    post 'message', to:'messages#create'
    mount ActionCable.server, at: '/cable'
    get '/search' => 'chatrooms#search', :as => 'search_page'
      # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
