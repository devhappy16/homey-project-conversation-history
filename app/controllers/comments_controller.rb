class CommentsController < ApplicationController
  before_action :set_project
  before_action :set_comment, only: %i[ edit update destroy ]
  before_action :build_comment, only: %i[ new ] # TODO: merge set_comment, build_comment
  before_action :authorize_comment

  # GET /comments or /comments.json
  def index
    @comments = @project.comments
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @comment = @project.comments.build(comment_params)
    @comment.user = Current.user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to project_path(@project), notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: [ @project, @comment ] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to project_path(@project), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: [ @project, @comment ] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to project_path(@project), notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_comment
      @comment = @project.comments.find(params[:id])
    end

    def build_comment
      @comment = @project.comments.build
    end

    def comment_params
      params.require(:comment).permit(:message)
    end

    def authorize_comment
      authorize @comment
    end
end
