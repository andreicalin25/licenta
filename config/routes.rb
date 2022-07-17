Rails.application.routes.draw do
  devise_for :users
  resources :enrollments
  resources :teachers_subjects
  resources :answers
  resources :questions
  resources :subjects
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "pages#home"
end
