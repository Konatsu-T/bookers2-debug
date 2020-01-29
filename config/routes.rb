Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show,:index,:edit,:update]
  resources :books do
  	resources :book_comments, only: [:create, :destroy]
  	resource :favorites, only: [:create, :destroy] do
  		post :create_show, on: :member
  		delete :destroy_show, on: :member
  	end
  end
  root 'homes#top'
  get 'home/about' => 'homes#about'
end
