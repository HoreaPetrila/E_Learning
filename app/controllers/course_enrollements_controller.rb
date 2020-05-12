class CourseEnrollementsController < ApplicationController
    before_action :set_course_enrollement, only: [:destroy] # set course_enroll for destroy action
    
    def index 
        @course_enrollements = current_user.course_enrollements
    end

    def show
      redirect_to course_path(course) # Self explanatory
    end

    def create
      @course_enrollement = CourseEnrollement.new(course_enrollements_params)
      respond_to do |format| 
        if  @course_enrollement.save
            format.html { redirect_to request.referer, notice: 'Course was successfully added' }
        else
            format.html { redirect_to request.referer, notice: 'Cannot enroll to course' }
        end
      end
    end

     def destroy
      @course_enrollement.destroy
      respond_to do |format|
        format.html { redirect_to request.referer, notice: 'Unsubcribed successfully' }
      end
     end

  private 
 
  def course_enrollements_params
     params.require(:course_enrollement).permit(:user_id, :course_id)
  end

  def set_course_enrollement
    # Unsubscribe from the outside using course_id and user_id
      if params[:course_id] && params[:user_id] # false if not present 
        @course_enrollement = current_user.course_enrollements.find_by_course_id(params[:course_id]) # set the enroll to destroy
      else 
    # Unsubscribe using enroll_id
       @course_enrollement = current_user.course_enrollements.find(params[:id]) 
      end
  end

end
