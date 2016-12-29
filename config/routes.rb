Rails.application.routes.draw do

    get 'proyectos/index'

    get    '/login',   to: 'sessions#new'
    post   '/login',   to: 'sessions#create'
    delete '/logout',  to: 'sessions#destroy'
    resources :empleados do
        resources :proyectos
    end

    root 'sessions#new'

  get 'empleados' => 'empleados#index'
    get   '/new', to: 'empleados#new'
    post  '/new', to: 'empleados#create'
  resources :empleados
    
end
