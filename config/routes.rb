Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  root to: "users#show"

  namespace :coc do
    resources :campaigns, only: [:new, :create, :show, :destroy]

    resources :characters do
      resources :characteristic_sets, only: [ :new, :create, :show ]
      resources :skill_sets, only: [ :new, :create, :edit, :update ]
      get '/weapons', to: 'weapons#edit'
      put '/weapons', to: 'weapons#update'
    end
  end

  namespace :dg do
    resources :campaigns, only: [:new, :create, :show, :destroy] do
      resources :characters, only: [:new, :create]
    end
    resources :characters, only: [:show, :edit, :update] do
      resources :statistic_sets, only: [:new, :create]
      resources :skill_sets, only: [:new, :create]
    end
  end

  resources :users, only: [:show]

  get '/name_maker/first/:gender', to: 'name_maker#first'
  get '/name_maker/surname', to: 'name_maker#surname'
  get '/name_maker/city', to: 'name_maker#city'
  get '/name_maker/date_of_birth', to: 'name_maker#date_of_birth'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
