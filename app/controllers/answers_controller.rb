class AnswersController < ApplicationController
  before_action :set_answer, only: %i[ show edit update destroy remove_file]
  before_action :authenticate_user!
  before_action :authorize_admin_active
  before_action :authorize_admin_creator, only: %i[edit update destroy]

  # # GET /answers or /answers.json
  # def index
  #   @answers = Answer.all
  # end

  # GET /my_answers
  def my_answers
    @my_answers = Answer.written_by_user(current_user.id)
  end

  # # GET /answers/1 or /answers/1.json
  # def show
  # end

  # # GET /answers/new
  # def new
  #   @answer = Answer.new
  # end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers or /answers.json
  def create
    @answer = Answer.new(answer_params)
    @answer.user = current_user

    respond_to do |format|
      if @answer.save
        format.html { redirect_to question_url(@answer.question_id), notice: "Answer was successfully created." }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answers/1 or /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to question_url(@answer.question_id), notice: "Answer was successfully updated." }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove_file
    respond_to do |format|
      if @answer.files.find(params[:file_id]).purge
        format.html { render :edit, status: :ok, notice: "File was removed." }
        format.json { render :edit, status: :ok, location: @question }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1 or /answers/1.json
  def destroy
    question_id = @answer.question.id
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to question_url(question_id), notice: "Answer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def answer_params
      params.require(:answer).permit(:text, :question_id, files: [])
    end

    def authorize_admin_creator
      return unless current_user.role != "ADMIN" and current_user.id != @answer.user.id
      redirect_to root_path, alert: 'Admins or creator only!'
    end
end
