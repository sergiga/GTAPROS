Rails.application.routes.draw do

  root 'sessions#new'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :empleados do
      resources :proyectos, only: [:index, :show]
  end
  resources :proyectos, only: [:show, :edit, :update, :destroy, :create] do
    resources :actividads
  end

  get 'proyectos' => 'proyectos#all'
  get   'proyectos/new'
  post  'proyectos/new', to: 'proyectos#create'
  get   'proyectos/all', to: 'proyectos#all'
  get   'proyectos/setmanager', to: 'proyectos#setmanager'
  post  'proyectos/setmanager', to: 'proyectos#setmanagerforproject'
  delete '/proyectos', to: 'proyectos#delete'
  resources :proyectos
end
