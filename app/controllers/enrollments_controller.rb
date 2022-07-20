class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: %i[ show destroy ]
  before_action :authenticate_user!
  before_action :authorize_admin_or_student

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

    def authorize_admin_or_student
      return unless current_user.role != "ADMIN" and current_user.role != "STUDENT"
      redirect_to root_path, alert: 'Admins and students only!'
    end
  end
