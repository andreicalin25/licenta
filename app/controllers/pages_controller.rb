class PagesController < ApplicationController
  def home
    if current_user and current_user.activated == true
      redirect_to questions_path
    else
      @questions = Question.all
    end
  end
end
