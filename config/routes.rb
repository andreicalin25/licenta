Rails.application.routes.draw do
  get 'pages/home'
  resources :answers
  resources :questions
  resources :students
  resources :groups
  resources :subjects
  resources :teachers
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"
end
