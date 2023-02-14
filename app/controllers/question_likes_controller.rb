class QuestionLikesController < ApplicationController
  before_action :find_question
  before_action :find_like, only: [:destroy]

  def create
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      @question.question_likes.create(user_id: current_user.id)
    end
    redirect_to question_path(@question)
  end

  def destroy
    if !(already_liked?)
      flash[:notice] = "Cannot unlike"
    else
      @question_like.destroy
    end
    redirect_to question_path(@question)
  end

  private
  def already_liked?
    QuestionLike.where(user_id: current_user.id, question_id:
      params[:question_id]).exists?
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_like
    @question_like = @question.question_likes.find(params[:id])
  end
end
