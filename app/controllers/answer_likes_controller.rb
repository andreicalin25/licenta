class AnswerLikesController < ApplicationController
  before_action :find_answer
  before_action :find_like, only: [:destroy]

  def create
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      @answer.answer_likes.create(user_id: current_user.id)
      @answer.answer_likes_count += 1
    end
    redirect_to question_path(@answer.question)
  end

  def destroy
    if !(already_liked?)
      flash[:notice] = "Cannot unlike"
    else
      @answer_like.destroy
      @answer.answer_likes_count -= 1
    end
    redirect_to question_path(@answer.question)
  end

  private
  def already_liked?
    AnswerLike.where(user_id: current_user.id, answer_id:
      params[:answer_id]).exists?
  end

  def find_answer
    @answer = Answer.find(params[:answer_id])
  end

  def find_like
    @answer_like = @answer.answer_likes.find(params[:id])
  end
end
