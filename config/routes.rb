Rails.application.routes.draw do

    get 'proyectos/index'

    get    '/login',   to: 'sessions#new'
    post   '/login',   to: 'sessions#create'
    delete '/logout',  to: 'sessions#destroy'
    resources :empleados do
        resources :proyectos
    end

    root 'sessions#new'
end
