Cairn::Application.routes.draw do
  devise_for :admin_users, :path => "_admin", controllers: { sessions: "admin/sessions" }
  devise_for :users, controllers: { registrations: "users/registrations" }

  scope "_admin", :as => "admin" do
    root :to => "admin#index"
    resources :change_requests, :module => "admin"
    put 'change_requests/:id/approve' => 'admin/change_requests#approve', :as => 'change_request_approve'
  end

  resources :organizations
  post '/organizations/:id/set_realm' => 'organizations#set_realm', :as => 'set_organization_realm'

  resources :atlases, :path => 'organizations/:organization_id/atlases', :as => 'atlases'

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
  root 'page#index'
end
