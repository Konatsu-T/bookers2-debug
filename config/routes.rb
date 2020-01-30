Rails.application.routes.draw do
  get 'searchs/search'
  get 'relationships/create'
  get 'relationships/destroy'
  devise_for :users
  resources :users, only: [:show,:index,:edit,:update] do
    resources :relationships, only: [:create, :destroy]do
   end
    get 'follows' => 'relationships#follower', as: 'follows'
    get 'followers' => 'relationships#followed', as: 'followers'
  end
  resources :books do
  	resources :book_comments, only: [:create, :destroy]
  	resource :favorites, only: [:create, :destroy] do
  		post :create_show, on: :member
  		delete :destroy_show, on: :member
  	end
  end
  root 'homes#top'
  get 'home/about' => 'homes#about'

  # root 'searches#search'
  get '/search', to: 'searches#search'

  # フォローする(users/index用)
  post 'follow/:id' => 'relationships#create', as: 'follow'
  # フォロー外す(users/index用)
  delete 'unfollow/:id' => 'relationships#destroy', as: 'unfollow'
end
