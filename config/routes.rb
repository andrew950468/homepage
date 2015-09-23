Rails.application.routes.draw do
  devise_for :users
	root 'main#index'
	resources :posts 
  get "user/index" => "user#index"
  post "posts/comment" => "posts#comment"
  post "posts/buyCount" => "posts#buyCount"
end

