Rails.application.routes.draw do

  mount ActionCable.server => '/cable'

  root to: 'landing#index'
  get :about, to: 'static_pages#about'
  resources :topics, except: [:show] do
  resources :posts, except: [:show] do
  resources :comments, except: [:show]
  end
end
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
resources :users, only: [:new, :edit, :update, :create]
resources :sessions, only: [:new, :create, :destroy]
resources :password_resets, only: [:new, :create, :edit, :update]

post :upvote, to: "votes#upvote"
post :downvote, to: "votes#downvote"

end
