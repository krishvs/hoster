class ProjectsController < ApplicationController

  #->Prelang (scaffolding:rails/scope_to_user)
  before_filter :require_user_signed_in, only: [:new, :edit, :create, :update, :destroy]

  before_action :set_project, only: [:show, :edit, :update, :destroy]
  layout "project"

  # GET /projects
  # GET /projects.json
  def projects
  end

  def index
    @projects = Project.all
    if request.headers['X-PJAX']
      render :layout => false
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    if request.headers['X-PJAX']
      render :layout => false
    end
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = current_user.projects.find_by_name(params[:project][:name])
    Rails.logger.debug "The value of the project is #{@project.nil?} #{params[:project][:name]}"
    if @project.nil?
      @project = Project.new(project_params)
      Rails.logger.debug "The value of the project_params is #{project_params}"
      @project.user = current_user

      respond_to do |format|
        if @project.save
          if request.xhr?
            format.json { 
                render json: {:message => @project.id.to_s}
            } 
          else
            format.html { redirect_to @project, notice: 'Project was successfully created.' }
            format.json { render :show, status: :created, location: @project }
          end
        else
          format.json { render json: @project.errors, status: :unprocessable_entity }
          format.html { render :new }
        end
      end
    else
      respond_to do |format|
        if request.xhr?
          format.json { 
              render json: {:message => @project.id.to_s}
          } 
        else
          format.html { redirect_to @project, notice: 'Project was successfully created.' }
          format.json { render :show, status: :created, location: @project }
        end
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :status, :user_id)
    end
end
