MyConfessorServer::Application.routes.draw do

  root 'main#index'

  # Begin Static Resources
  get 'states(.:format)', to: 'states#index', as: :states
  get 'states/:id(.:format)', to: 'states#show', as: :state

  get 'dioceses(.:format)', to: 'dioceses#index', as: :dioceses
  get 'dioceses/:id(.:format)', to: 'dioceses#show', as: :diocese

  get 'account_statuses(.:format)', to: 'account_statuses#index', as: :account_statuses
  get 'account_statuses/:id(.:format)', to: 'account_statuses#show', as: :account_status

  get 'account_roles(.:format)', to: 'account_roles#index', as: :account_roles
  get 'account_roles/:id(.:format)', to: 'account_roles#show', as: :account_role

  get 'confessor_request_statuses(.:format)', to: 'confessor_request_statuses#index', as: :confessor_request_statuses
  get 'confessor_request_statuses/:id(.:format)', to: 'confessor_request_statuses#show', as: :confessor_request_status

  get 'confessor_offices(.:format)', to: 'confessor_offices#index', as: :confessor_offices
  get 'confessor_offices/:id(.:format)', to: 'confessor_offices#show', as: :confessor_office

  get 'confessor_statuses(.:format)', to: 'confessor_statuses#index', as: :confessor_statuses
  get 'confessor_statuses/:id(.:format)', to: 'confessor_statuses#show', as: :confessor_status
  # End Static Resources

  # User Accounts
  resources :user_accounts
  # User Account Histories
  get 'user_account_changes(.:format)', to: 'user_account_changes#index', as: :user_account_changes
  get 'user_account_changes/:id(.:format)', to: 'user_account_changes#show', as: :user_account_change

  # User Accounts
  resources :confession_locations
  # User Account Histories
  get 'confession_location_changes(.:format)', to: 'confession_location_changes#index', as: :confession_location_changes
  get 'confession_location_changes/:id(.:format)', to: 'confession_location_changes#show', as: :confession_location_change

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
