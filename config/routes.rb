Yapos::Application.routes.draw do
  resources :vendor_item_fields

  resources :vendor_items, only: :create

  resources :products do
    resources :vendor_items
  end

  devise_for :users

  get 'kanban', to: 'kanban#show'
  get 'price_movements', to: 'price_movement#index', as: :price_movements
  get 'price_movement/:vendor_item_id', to: 'price_movement#show', as: :price_movement
  get 'price_movements/uncategorized', to: 'price_movement#uncategorized', as: :uncategorized_offers
  get 'price_movements/unvendored', to: 'price_movement#unvendored', as: :unvendored_offers

  resources :stocks

  # resources :offers
  patch 'offers/vendor_code_update/:id', to: 'offers#vendor_code_update', as: :vendor_code_update

  resources :orders do
    collection do
      get 'pending'
      get 'print_delivery_monitoring'
    end
    resources :attachments do
      member do
        get 'document'
      end
    end
  end

  resources :offers do
    member do
      put 'update'
      patch 'quick_purchase'
    end
  end

  resources :supplier_orders, only: :update

  resources :supplier_purchases do
    member do
      get 'print'
    end
  end

  resources :suppliers


  resources :clients  do
    resources :offers, module: 'clients'
  end

  resources :quotes do
    collection do
      get 'pending'
      get 'pending_client_po'
    end
    member do
      get 'requote'
      get 'printable_view'
    end
    resources :attachments do
      member do
        get 'document'
      end
    end
  end

  root :to => 'quotes#index'

  get 'search' => 'searches#search', :as => 'search'
  get 'accounting' => 'accounting#index', :as => 'accounting'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
