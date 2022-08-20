Rails.application.routes.draw do

  devise_for :users
  resources :enrollments
  resources :teachers_subjects
  resources :questions do
    resources :question_likes
  end
  post "/questions/:id/remove_file" => "questions#remove_file", as: 'question_remove_file'

  resources :answer_likes
  resources :answers
  post "/answers/:id/remove_file" => "answers#remove_file", as: 'answer_remove_file'

  resources :subjects

  namespace :admin do
    resources :users
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "pages#home"


  get "/my_questions" => "questions#my_questions"
  get "/my_answers" => "answers#my_answers"
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
