class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: %i[ show edit update destroy ]

  # GET /enrollments or /enrollments.json
  def index
    if current_user.role == "STUDENT"
      @enrollments_of_student = Enrollment.enrollments_of_student(current_user.id)
      @teachers_subjects_not_of_student = TeachersSubject.teachers_subjects_not_of_student(current_user.id)
    else
      @enrollments = Enrollment.all
    end
  end

  # GET /enrollments/1 or /enrollments/1.json
  def show
  end

  # GET /enrollments/new
  # def new
  #   @enrollment = Enrollment.new
  # end

  # GET /enrollments/1/edit
  # def edit
  # end

  # POST /enrollments or /enrollments.json
  def create
    @enrollment = Enrollment.new(enrollment_creation_params)

    respond_to do |format|
      if @enrollment.save
        format.html { redirect_to enrollments_url, notice: "Enrollment was successfully created." }
        format.json { render :show, status: :created, location: @enrollment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { head :no_content }
      end
    end
  end

  # PATCH/PUT /enrollments/1 or /enrollments/1.json
  # def update
  #   respond_to do |format|
  #     if @enrollment.update(enrollment_params)
  #       format.html { redirect_to enrollment_url(@enrollment), notice: "Enrollment was successfully updated." }
  #       format.json { render :show, status: :ok, location: @enrollment }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @enrollment.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /enrollments/1 or /enrollments/1.json
  def destroy
    @enrollment.destroy

    respond_to do |format|
      format.html { redirect_to enrollments_url, notice: "Enrollment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enrollment
      @enrollment = Enrollment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def enrollment_params
      params.fetch(:enrollment, {})
    end

    def enrollment_creation_params
      params.require(:data).permit(:student_id, :teachers_subject_id)
    end
end
