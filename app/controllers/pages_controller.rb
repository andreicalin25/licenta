class PagesController < ApplicationController
  def home
    if current_user
      redirect_to questions_path
    else
      @questions = Question.all
    end
  end
end
