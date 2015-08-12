Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'jample#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  get 'set_current_patch/:id' => 'jample#set_current_patch'
  get 'randomize_current_patch' => 'jample#randomize_current_patch'
  post 'set_filter/' => 'jample#set_filter'


  get 'shrink_patch_by_one_on_the_end/' => 'jample#shrink_patch_by_one_on_the_end'
  get 'grow_patch_by_one_on_the_end/' => 'jample#grow_patch_by_one_on_the_end'
  get 'shift_sample_backward_one_slice/' => 'jample#shift_sample_backward_one_slice'
  get 'shift_sample_forward_one_slice/' => 'jample#shift_sample_forward_one_slice'
  get 'set_volume/:volume' => 'jample#set_volume'

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
