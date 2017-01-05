Rails.application.routes.draw do

  root 'sessions#new'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :empleados do
      resources :proyectos, only: [:index, :show]
  end
  delete '/empleados', to: 'empleados#delete'
  
  resources :proyectos, only: [:new, :create]
  get   'proyectos/setmanager', to: 'proyectos#setmanager'
  post  'proyectos/setmanager', to: 'proyectos#setmanagerforproject'
  put 'proyectos/:id/init', to: 'proyectos#init', as: 'proyectos_init'

  resources :proyectos, only: [:show, :edit, :update, :destroy] do
    resources :actividads, only: [:new, :create, :show]
    resources :asignacion_proyectos, only: [:new, :create]
  end

  resources :actividads, only: [:show] do
    resources :tarea_personals
  end
  get 'actividads/:id/setempleado', to: 'actividads#setempleadonew', as: 'new_actividad_setempleado'
  post 'actividads/:id/setempleado', to: 'actividads#setempleadocreate', as: 'create_actividad_setempleado'
  
  delete 'proyectos' => 'proyectos#delete'
  get 'proyectos' => 'proyectos#all'
#  get   'proyectos/new'
#  post  'proyectos/new', to: 'proyectos#create'
#  get   'proyectos/all', to: 'proyectos#all'
#  get   'proyectos/setmanager', to: 'proyectos#setmanager'
#  post  'proyectos/setmanager', to: 'proyectos#setmanagerforproject'
#  delete '/proyectos', to: 'proyectos#delete'
#  put 'proyectos/:id/init', to: 'proyectos#init', as: 'proyectos_init'

  get 'calendar/:id', to: 'calendar#index', as: 'calendar'
  get 'calendar/:id/actividades', to: 'calendar#actividades', as: 'calendar_actividades'
  get 'calendar/:id/vacaciones', to: 'calendar#vacaciones', as: 'calendar_vacaciones'
  post 'calendar/:id/pedir_vacaciones', to: 'calendar#pedirvacaciones', as: 'pedir_vacaciones'
end
