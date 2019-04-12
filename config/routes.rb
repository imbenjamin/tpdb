Rails.application.routes.draw do
    devise_for :users
    
    get 'welcome/index'
    
    scope "(/:locale)", locale: /#{I18n.available_locales.join("|")}/, defaults: {locale: "en"} do
        resources :locations, param: :slug do
            resources :attractions, param: :slug, only: [:show]
            resources :areas, param: :slug, only: [:index, :show]
        end
        resources :attractions, param: :slug, only: [:index, :edit, :update, :destroy, :create, :new]
        resources :attraction_types, param: :slug
        resources :areas, param: :slug, only: [:edit, :update, :destroy, :create, :new]
        resources :manufacturers, param: :slug
        get 'search' => 'search#new'
        post 'search' => 'search#create'

        get 'attractions/:slug', action: :show, controller: 'attractions'
        get 'areas/:slug', action: :show, controller: 'areas'
    end

    namespace :api do
        scope 'v1' do
            resources :locations
            resources :areas
            resources :attractions
            resources :attraction_types
            resources :manufacturers
        end
    end
    
    get '/api/*anything', to: redirect('/api/v1/%{anything}')
    get '/:locale' => 'welcome#index'
    root 'welcome#index'
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
