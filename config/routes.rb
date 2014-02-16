MyConfessorServer::Application.routes.draw do

  root 'main#index'                            #Main site page
  
  # Admin pages  
  get 'admin' => 'main#admin', as: :admin      #Admin home page
  get 'admin/confessors/:id/status' => 'confessors#status', as: :confessor_status

  # Priest pages
  get 'priest' => 'main#priest', as: :priest   #Priest home page
  get 'priest/status' => 'confessors#status', as: :priest_status

  #TODO These were used by the json stuff. Delete?  
  get 'test', to: 'main#test'
  get 'ping', to: 'main#ping'
  
  #JS site stuff
  get 'site/priest', to: 'main#priest'
  get 'site/admin', to: 'main#admin'
  get 'site', to: 'main#penitent'
  
  #devise_for :user_accounts
  devise_for :user_accounts, :only => :sessions
  #:controllers => { :registrations => "user_accounts" } #Other controller optiopns are :sessions and :passwords. TODO: need to circle back and clean up all routes to the bare minimum needed.

  scope '/admin' do
    # Begin Static Resources - can comment these out later, unless we still do the JS site.
    resources :states, only: [:index, :show]
    resources :dioceses, only: [:index, :show]
    resources :account_statuses, only: [:index, :show]
    resources :account_roles, only: [:index, :show]
    resources :confessor_request_statuses, only: [:index, :show]
    resources :confessor_offices, only: [:index, :show]
    resources :confession_statuses, only: [:index, :show]
    # End Static Resources
    
    # User Accounts
    resources :user_accounts, except: [:delete, :show]
    resources :user_account_changes, only: [:index, :show]
    
    # Confession locations
    resources :confession_locations, except: [:delete]
    resources :confession_location_changes, only: [:index, :show]
    
    # Confessors
    resources :confessors, except: [:delete]
    resources :confessor_changes, only: [:index, :show]
    
    # Confessor Requests
    resources :confessor_requests, except: [:delete]
    resources :confessor_request_changes, only: [:index, :show]
  end

  #(.:format) means an optional param following a period, that becomes the :format param.
  #get '/confessors/:id/status(.:format)', to: 'confessors#status', as: 'confessor_status'
  #get '/confessors/:id/status/edit(.:format)', to: 'confessors#edit_status', as: 'edit_confessor_status'
  #get '/confessors/:id/settings/edit(.:format)', to: 'confessors#edit_settings', as: 'edit_confessor_settings'  
  



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
