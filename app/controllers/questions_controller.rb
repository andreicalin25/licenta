class QuestionsController < ApplicationController
  before_action :set_question, only: %i[ show edit update destroy remove_file]
  before_action :authenticate_user!
  before_action :authorize_admin_creator, only: %i[edit update destroy]
  before_action :authorize_admin_active

  # GET /questions or /questions.json
  def index
    if params[:q].present? and params[:q][:title_or_details_i_cont_any].present?
      words = params[:q][:title_or_details_i_cont_any].split(" ")
      params[:q][:title_or_details_i_cont_any] = words
    end

    @q = Question.ransack(params[:q])
    @questions = @q.result(distinct: true)

    if current_user.role == "STUDENT"
      @questions = @questions.questions_for_student(current_user.id)
      @subjects = Subject.subjects_of_student(current_user.id)

      if params[:subject]
        @questions = @questions.questions_for_student_by_subject(current_user.id, params[:subject])
      end
    elsif current_user.role == "TEACHER"
      @questions = @questions.questions_for_teacher(current_user.id)
      @subjects = Subject.subjects_of_teacher(current_user.id)

      if params[:subject]
        @questions = @questions.questions_for_teacher_by_subject(current_user.id, params[:subject])
      end
    else
      @questions = @questions.all
    end
    
    @questions = @questions.sort_by { |q| q.created_at }.reverse
    
    if params[:sort] == 'title-cresc'
      @questions = @questions.sort_by { |q| q.title }
    elsif params[:sort] == 'title-desc'
      @questions = @questions.sort_by { |q| q.title }.reverse
    elsif params[:sort] == 'time-cresc'
      @questions = @questions.sort_by { |q| q.created_at }
    elsif params[:sort] == 'time-desc'
      @questions = @questions.sort_by { |q| q.created_at }.reverse
    elsif params[:sort] == 'likes-cresc'
      @questions = @questions.sort_by { |q| q.question_likes.count }
    elsif params[:sort] == 'likes-desc'
      @questions = @questions.sort_by { |q| q.question_likes.count }.reverse
    elsif params[:sort] == 'answers-cresc'
      @questions = @questions.sort_by { |q| q.answers.count }
    elsif params[:sort] == 'answers-desc'
      @questions = @questions.sort_by { |q| q.answers.count }.reverse
    end
  end

  # GET /my_questions
  def my_questions
    @my_questions = Question.asked_by_student(current_user.id)
  end

  # GET /questions/1 or /questions/1.json
  def show
    if params[:q].present? and params[:q][:text_i_cont_any].present?
      words = params[:q][:text_i_cont_any].split(" ")
      params[:q][:text_i_cont_any] = words
    end

    @answers = Answer.of_question(@question.id)
    @q = @answers.ransack(params[:q])
    @answers = @q.result(distinct: true)

    @answer = @question.answers.build

    if params[:sort] == 'time-cresc'
      @answers = @answers.sort_by { |a| a.created_at }
    elsif params[:sort] == 'time-desc'
      @answers = @answers.sort_by { |a| a.created_at }.reverse
    elsif params[:sort] == 'likes-cresc'
      @answers = @answers.sort_by { |a| a.answer_likes.count }
    elsif params[:sort] == 'likes-desc'
      @answers = @answers.sort_by { |a| a.answer_likes.count }.reverse
    end
  end

  # GET /questions/new
  def new
    @question = Question.new
    @my_enrollments = Enrollment.enrollments_of_student(current_user.id)
  end

  # GET /questions/1/edit
  def edit
    @my_enrollments = Enrollment.enrollments_of_student(current_user.id)
  end

  # POST /questions or /questions.json
  def create
    @my_enrollments = Enrollment.enrollments_of_student(current_user.id)
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to question_url(@question), notice: "Question was successfully created." }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1 or /questions/1.json
  def update
    @my_enrollments = Enrollment.enrollments_of_student(current_user.id)

    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to question_url(@question), notice: "Question was successfully updated." }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  def remove_file
    @my_enrollments = Enrollment.enrollments_of_student(current_user.id)

    respond_to do |format|
      if @question.files.find(params[:file_id]).purge
        format.html { render :edit, status: :ok, notice: "File was removed." }
        format.json { render :edit, status: :ok, location: @question }
        format.turbo_stream { render :form_update, status: :ok }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1 or /questions/1.json
  def destroy
    @question.destroy

    respond_to do |format|
      format.html { redirect_to questions_url, notice: "Question was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:question).permit(:title, :details, :importance, :enrollment_id, :anonymous, files: [])
    end

    def authorize_admin_creator
      return unless current_user.role != "ADMIN" and current_user.id != @question.enrollment.student.id
      redirect_to root_path, alert: 'Admins or creator only!'
    end
end
