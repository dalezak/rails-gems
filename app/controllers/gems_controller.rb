class GemsController < ApplicationController
  before_action :set_user, only: [:index]
  before_action :set_tag, only: [:index]
  before_action :set_gem, only: [:edit, :update, :destroy, :like]

  def index
    authorize! :index, Gemm
    @search = params.fetch(:search, nil)
    @offset = params.fetch(:offset, 0).to_i
    @limit = [params.fetch(:limit, 24).to_i, 48].min
    order = [likes_count: :desc, stars_count: :desc, downloads_count: :desc]
    query = Gemm.
      with_tags(true).
      for_tag(@tag).
      for_user(@user).
      for_search(@search)
    @gems = query.limit(@limit).offset(@offset).order(order)
    @gems_count = query.count(:all) unless request.format.json?
    if @search.present? && @gems.count.zero?
      Gems.search(@search).to_a.take(@limit).each do |result|
        Gemm.import_rubygems(result)
      end
      @gems = query.limit(@limit).offset(@offset).order(order)
      @gems_count = query.count(:all) unless request.format.json?
    end
    respond_to do |format|
      format.html { }
      format.json { }
      format.turbo_stream { }
    end
  end

  def show
    @gem = Gemm.with_tags(true).for_slug(params[:id]).first!
    authorize! :show, @gem
  end

  def new
    authorize! :new, Gemm
    @gem = Gemm.new
  end

  def edit
    authorize! :edit, @gem
  end

  def create
    authorize! :create, Gemm
    @gem = Gemm.new(gem_params)
    respond_to do |format|
      if @gem.save
        format.html { redirect_to @gem, notice: 'Gem was successfully created.' }
        format.json { render :show, status: :created, location: @gem }
      else
        format.html { render :new }
        format.json { render json: { error: @gem.errors.full_messages.to_sentence }, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize! :update, @gem
    respond_to do |format|
      if @gem.update(gem_params)
        format.html { redirect_to @gem, notice: 'Gem was successfully updated.' }
        format.json { render :show, status: :ok, location: @gem }
      else
        format.html { render :edit }
        format.json { render json: { error: @gem.errors.full_messages.to_sentence }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize! :destroy, @gem
    @gem.destroy
    respond_to do |format|
      format.html { redirect_to gems_url, notice: 'Gem was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def like
    if user_signed_in?
      authorize! :like, @gem
      @like = Like.for_user(current_user).for_gem(@gem).first
      if @like.present?
        @like.destroy
      else
        @like = Like.create(gem: @gem, user: current_user)
      end
      @gem.reload
      respond_to do |format|
        format.html { redirect_to gem_path(@gem) }
        format.turbo_stream { }
      end
    else
      respond_to do |format|
        format.html { redirect_to new_user_session_path }
        format.turbo_stream { render turbo_stream: turbo_stream.update("modal", template: '/devise/sessions/new', locals: { turbo: true }) }
      end
    end
  end

  private

  def set_gem
    @gem = Gemm.find(params[:id])
  end

  def set_user
    if params[:user_id].present?
      @user = User.find(params[:user_id])
    end
  end

  def set_tag
    if params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
    end
  end

  def gem_params
    params.require(:gem).permit(
      :name,
      :title,
      :description,
      :authors,
      :licenses,
      :version,
      :platform,
      :tag_list)
  end

end

