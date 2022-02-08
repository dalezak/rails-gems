class TagsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  def index
    authorize! :index, Tag
    @search = params.fetch(:search, nil)
    @offset = params.fetch(:offset, 0).to_i
    @limit = [params.fetch(:limit, 24).to_i, 48].min
    query = Tag.for_search(@search)
    @tags = query.limit(@limit).offset(@offset).order(taggings_count: :desc)
    @tags_count = query.count(:all) if request.format.html?
    respond_to do |format|
      format.html { }
      format.json { }
      format.turbo_stream { }
    end
  end

  def show
    authorize! :show, @tag
  end

  def new
    authorize! :new, Tag
    @tag = Tag.new
  end

  def edit
    authorize! :edit, @tag
  end

  def create
    authorize! :create, Tag
    @tag = Tag.new(tag_params)
    respond_to do |format|
      if @tag.save
        format.html { redirect_to @tag, notice: 'Tag was successfully created.' }
        format.json { render :show, status: :created, location: @tag }
      else
        format.html { render :new }
        format.json { render json: { error: @tag.errors.full_messages.to_sentence }, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize! :update, @tag
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to @tag, notice: 'Tag was successfully updated.' }
        format.json { render :show, status: :ok, location: @tag }
      else
        format.html { render :edit }
        format.json { render json: { error: @tag.errors.full_messages.to_sentence }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize! :destroy, @tag
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to tags_url, notice: 'Tag was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end

end

