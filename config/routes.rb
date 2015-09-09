Rails.application.routes.draw do
	root 'posts#new'
	resources :posts 
end

