class UsersController < ApplicationController
  before_action :set_gem, only: [:index]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    authorize! :index, User
    @search = params.fetch(:search, nil)
    @offset = params.fetch(:offset, 0).to_i
    @limit = [params.fetch(:limit, 24).to_i, 48].min
    query = User.
      for_gem(@gem).
      for_search(@search)
    @users = query.limit(@limit).offset(@offset).order(created_at: :asc).all
    @users_count = query.count(:all) if request.format.html?
    respond_to do |format|
      format.html { }
      format.json { }
      format.turbo_stream { }
    end
  end

  def show
    authorize! :show, @user
  end

  def new
    authorize! :new, User
    @user = User.new
  end

  def edit
    authorize! :edit, @user
  end

  def create
    authorize! :create, User
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: { error: @user.errors.full_messages.to_sentence }, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize! :update, @user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: { error: @user.errors.full_messages.to_sentence }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize! :destroy, @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def profile
    authorize! :show, current_user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_gem
    if params[:gem_id].present?
      @gem = Gemm.find(params[:gem_id])
    end
  end

  def user_params
    params.require(:user).permit(:name, :username, :title, :description)
  end

end

