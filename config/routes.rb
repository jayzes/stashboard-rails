StashboardRails::Application.routes.draw do

  resources :services

  scope 'api/v1' do
    
    resources :services do
      resources :events do
        get 'current', :on => :collection
      end
    end
    
    resources :levels,        :only => :index
    resources :statuses
    resources :status_images, :only => :index
  end
  
  root :to => 'services#index'

end
