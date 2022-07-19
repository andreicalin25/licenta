class TeachersSubjectsController < ApplicationController
  def create
    @teachers_subject = TeachersSubject.new(teachers_subject_params)

    respond_to do |format|
      if @teachers_subject.save
        format.html { redirect_to subjects_url, notice: "Subject was successfully added." }
        format.json { head :no_content }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { head :no_content }
      end
    end
  end

  def destroy
    @teachers_subject = TeachersSubject.find_by(teachers_subject_params).first
    puts @teachers_subject || "\n\n!!!no one found\n\n"
    respond_to do |format|
      format.html { redirect_to subjects_url, notice: "Subject was successfully removed." }
      format.json { head :no_content }
    end
  end

  private
  def teachers_subject_params
    params.require(:data).permit(:subject_id, :teacher_id)
  end
end
