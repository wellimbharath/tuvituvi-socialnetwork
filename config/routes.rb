Rails.application.routes.draw do
 

  resources :messages
  resources :conversations
  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'} ,:controllers => { registrations: "registrations", sessions: 'sessions' }
  devise_scope :user do
    get 'register', to: 'devise/registrations#new', as:  :register
    get 'login', to: 'devise/sessions#new', as:  :login
    get 'logout', to: 'devise/sessions#destroy', as:  :logout , method: :delete
    get 'settings', to: 'devise/registrations#edit', as:  :settings   
  end
  authenticated :user do
    root to: 'posts#index', as: 'home'
  end
  unauthenticated :user do
    root 'home#index'
  end

  resources :users do
    member do
      get :confirm_email
    end
  end

  resources :dreams
  

  resources :chats
  resources :users
  resources :learns
  resources :activities
  resources :sounds
  resources :creates
  resources :videos
  resources :galleries
   get 'learn/index'
   get 'pages/terms'
   get 'pages/about'
    get 'pages/contact'
 resources :pages
  resources 'home'
  resources :learn
  resources :post do
    member do
        put "like", to: "posts#upvote"
        put "dislike", to: "posts#downvote"
    end
  end
  resources :conversations do
    resources :messages
  end
  resources :posts do  
   resources :comments
  end  
  resources :comments do  
   resources :replies
  end  
  resources :followings
  resources :follows
  resources :people
  resources :profile
  resources :update
  resources :feed
  resources :user_networks do
    member do
      put :block
    end
  end


/ this should be in the down /
  get ':username', to: 'profile#show', as: :username
  get ':username/biography' , to: 'biography#index', as: :biography
  
end
