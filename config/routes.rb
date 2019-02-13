Rails.application.routes.draw do
  resources :topics
  resources :subjects, except: :destroy
  resources :users
  resources :jobs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'

  get '/job_board', to: 'jobs#job_board'
  # post '/job_board', to: 'jobs#add_tutor_or_student'


end
