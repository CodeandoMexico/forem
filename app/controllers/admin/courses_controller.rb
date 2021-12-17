class Admin::CoursesController < ApplicationController
  before_action :set_admin_course, only: %i[ show edit update destroy ]

  # GET /admin/courses or /admin/courses.json
  def index
    @admin_courses = Admin::Course.all
  end

  # GET /admin/courses/1 or /admin/courses/1.json
  def show
  end

  # GET /admin/courses/new
  def new
    @admin_course = Admin::Course.new
  end

  # GET /admin/courses/1/edit
  def edit
  end

  # POST /admin/courses or /admin/courses.json
  def create
    @admin_course = Admin::Course.new(admin_course_params)

    respond_to do |format|
      if @admin_course.save
        format.html { redirect_to @admin_course, notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @admin_course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/courses/1 or /admin/courses/1.json
  def update
    respond_to do |format|
      if @admin_course.update(admin_course_params)
        format.html { redirect_to @admin_course, notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/courses/1 or /admin/courses/1.json
  def destroy
    @admin_course.destroy
    respond_to do |format|
      format.html { redirect_to admin_courses_url, notice: "Course was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_course
      @admin_course = Admin::Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_course_params
      params.require(:admin_course).permit(:name, :published, :slug, :description, :meta_description, :meta_title)
    end
end
