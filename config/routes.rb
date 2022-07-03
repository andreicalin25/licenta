Rails.application.routes.draw do
  resources :enrollments
  resources :teachers_subjects
  get 'pages/home'
  resources :answers
  resources :questions
  resources :students
  resources :subjects
  resources :teachers
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"
end
