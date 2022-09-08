class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin_active, only: %i[ranking]

  def home
    if current_user and current_user.activated == true
      redirect_to questions_path
    else
      @questions = Question.all
    end
  end

  def ranking

    if current_user.role == "STUDENT"
      @my_teachers_subjects = TeachersSubject.of_student(current_user.id)
      @subjects = Subject.subjects_of_student(current_user.id)

    elsif current_user.role == 'TEACHER'
      @my_teachers_subjects = TeachersSubject.of_teacher(current_user.id)
      @subjects = Subject.subjects_of_teacher(current_user.id)

    else
      @my_teachers_subjects = TeachersSubject.all
      @subjects = Subject.all
    end

    if params[:ts] == 'nil'
      params[:ts] = nil
    end

    @most_active_students = User.most_active_students(params[:ts])
    @most_appreciated_students = User.most_appreciated_students(params[:ts])
  end
end
