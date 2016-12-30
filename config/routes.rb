Rails.application.routes.draw do

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
    delete '/empleados', to: 'empleados#delete'

  get 'proyectos' => 'proyectos#all'
    get   'proyectos/new'
    post  'proyectos/new', to: 'proyectos#create'
    get   'proyectos/all', to: 'proyectos#all'
    get   'proyectos/setmanager', to: 'proyectos#setmanager'
    post  'proyectos/setmanager', to: 'proyectos#setmanagerforproject'
    delete '/proyectos', to: 'proyectos#delete'
  resources :proyectos
end
