require 'fastimage'

class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
    @pieces = Array.new

    @projects.each do |project|
      size = FastImage.size "app/assets/images/projects/#{project.pic_url}"
      @pieces << Array.new([
                  ActionController::Base.helpers.asset_path('projects/' + project.pic_url, type: :image),
                  project.site_url, 
                  size[0], 
                  size[1], 
                  project.name,
                  project.categories
                  ])
    end

    @indexes = Array.new
    @design = Array.new
    @code = Array.new
    @sesame = Array.new
    @general = Array.new
    @favorite = Array.new

    @pieces.each_with_index do |piece, index| 
      @indexes << index
      @design << index if piece[5].include? "DESIGN"
      @code << index if piece[5].include? "CODE"
      @sesame << index if piece[5].include? "SESAME"
      @general << index if piece[5].include? "GENERAL"
      @favorite << index if piece[5].include? "FAVORITE"
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    respond_to do |format|
      format.html { }
      format.js { }
    end
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
    respond_to do |format|
      format.html { @project }
      format.js { @project }
    end
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.js { redirect_to @project }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.js { redirect_to @project }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.js { redirect_to @project }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @id = params[:id]
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.js {  }
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
      params.require(:project).permit(:name, :pic_url, :site_url, :categories, :technologies_used)
    end
end
