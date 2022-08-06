Rails.application.routes.draw do

  devise_for :users
  resources :enrollments
  resources :teachers_subjects
  resources :questions do
    resources :question_likes
  end
  resources :answer_likes
  resources :answers
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
