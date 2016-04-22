Groupmates::Application.routes.draw do

  root "home#index"

  get 'education' => 'home#education'
  get 'business' => 'home#business'
  get 'features' => 'home#features'
  get 'about' => 'home#about'
  get 'team', to: 'home#team'

  #get 'search', to: 'home#search'
  #post 'subscribe' => 'subscriptions#subscribe'

  get 'contact' => 'contacts#new'
  get 'download/:id', to: 'assets#download', as: 'asset'
  resources "contacts", only: [:new, :create]
  get "/r/:ref" => "subscriptions#refer", as: 'refer'
  get 'referral' => 'subscriptions#referral'
  get 'terms-of-conditions' => 'home#terms', as: 'terms'
  get 'cookies-policy' => 'home#cookiespolicy', as: 'cookiespolicy'
  get 'scotedge' => 'home#scotedge', as: 'scotedge'
  get 'abuni' => 'home#prenium'

  get "export/notes/(/:note_id)" => "home#export_pdf", as: 'exportpdf'


  #Errors
  get "/404" => "errors#not_found"
  get "/500" => "errors#internal_server_error"

  # Users
  devise_for :users, :controllers => {
    registrations: 'registrations', 
    sessions: 'sessions', 
    passwords: 'passwords', 
    omniauth_callbacks: 'omniauth_callbacks',
  }

  #Projects
  resources :projects do
    get 'join' => 'projects#join' 
  end
  get '/p/:slug' => "projects#dashboard", as: 'p'
  get 'checkname' => 'projects#checkname'

  #Api
  namespace :api do
    namespace :v1 do

      devise_for :users, :controllers => { 
        registrations: 'api/v1/registrations',
        sessions: 'api/v1/sessions',
        passwords: 'api/v1/passwords',
        }, 
        skip: [ :omniauth_callbacks ]



      resources :projects, :defaults => {:format => 'json'} do 
        resources :users, :controller => 'assignations', :only => [:index, :create, :destroy]
        resources :events
        
        resources :notes do
          collection do
            get :shared
          end
        end
        
        get 'assets/root' => 'assets#root'
        get 'assets/exists' => 'assets#exists'
        get 'assets/versions/:id' => 'assets#versions'
        resources :assets do
          patch 'rename' => 'assets#rename'
        end

        resources :channels do
          resources :msg_views do
            collection do
              #patch 'view' => 'msg_views#view'
              patch :view
            end
          end
          resources :messages
        end

        resources :folders
        resources :invitations
        resource :assignations, only: [:update]

        # Interactive help
        get 'welcome' => 'help#welcome'
        get 'invitation' => 'help#invitation'

      end

      resources :users , :defaults => {:format => 'json'} do
        resources :preferences
        resources :reviews, only: [:index, :create, :show]
        resources :favorites, only: [:index, :show, :create, :destroy]
        get 'updateproject/:project_id' => 'users#updateproject'
      end

      # Pusher auth
      #get 'pusher/auth' => 'pusher#auth'
      post 'pusher/auth', :controller => 'pusher', :action => 'auth'
      # Return the current user information
      get 'user' => 'users#current'
      # For test purpose (Android, etc)
      get 'tasks' => 'tasks#index', :as => 'tasks'
    end
  end
  
  #for beginners, but not best practice
  #match ':controller(/:action(/:id(.:format)))', :via => :get

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
