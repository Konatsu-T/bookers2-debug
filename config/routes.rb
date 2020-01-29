Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  devise_for :users
  resources :users, only: [:show,:index,:edit,:update] do
    resources :relationships, only: [:create, :destroy]do
    # user/showページ上で、フォローする・外すボタンのリダイレクト先を設定するため
    post :create_show, on: :member
    delete :destroy_show, on: :member
    # ユーザーのフォロー・フォロワー一覧ページで、フォローする・外すボタンのリダイレクト先を設定するため
    post :follows_index, on: :member
    delete :followers_index, on: :member
    # 各ユーザーのフォロー・フォロワー一覧ページにIDを持たせるため
    get :follows, on: :collection
    get :followers, on: :collection
   end
   get '/follows' => 'users#follows'
   get '/followers' => 'users#followers'
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

  # フォローする(users/index用)
  post 'follow/:id' => 'relationships#create', as: 'follow'
  # フォロー外す(users/index用)
  delete 'unfollow/:id' => 'relationships#destroy', as: 'unfollow'
end
