Rails.application.routes.draw do

  get 'sessions/login'

  get 'sessions/logout'

  resources :posts do
    resources :comments
  end
  resources :users, only: [:new, :create]
  resources :sessions, only: [:create]

  resources :posts do
    member do
      put "like", to: "posts#upvote"
      put "dislike", to: "posts#downvote"
    end
  end

  #GET	/posts	posts#index	display a list of all posts
  #GET	/posts/new	posts#new	return an HTML form for creating a new post
  #POST	/posts	posts#create	create a new post
  #GET	/posts/:id	posts#show	display a specific post
  #GET	/posts/:id/edit	posts#edit	return an HTML form for editing a post
  #PATCH/PUT	/posts/:id	posts#update	update a specific post
  #DELETE	/posts/:id	photos#destroy	delete a specific post

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  get 'registration' => 'users#new'#, as: 'registration'

  get 'popular_posts' => 'posts#popular'
  get 'active_posts' => 'posts#active'

  # You can have the root of your site routed with "root"
  root 'posts#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
