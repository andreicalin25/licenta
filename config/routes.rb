Rails.application.routes.draw do
  resources :answers
  resources :questions
  resources :students
  resources :groups
  resources :subjects
  resources :teachers
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "questions#index"
end
