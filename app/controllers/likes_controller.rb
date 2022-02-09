class LikesController < ApplicationController
  before_action :set_gem

  def create
    if already_liked?
      flash[:notice] = "You can not like more than once"
    else
      @like = Like.create(gem: @gem, user: current_user)
      @gem.reload
      @gem.liked = true
    end
    respond_to do |format|
      format.html { redirect_to gem_path(@gem) }
      format.turbo_stream { }
    end
  end

  def destroy
    if already_liked?
      @like = Like.for_user(current_user).for_gem(@gem).first
      @like.destroy
      @gem.reload
      @gem.liked = false
    else
      flash[:notice] = "You have not liked this yet"
    end
    respond_to do |format|
      format.html { redirect_to gem_path(@gem) }
      format.turbo_stream { }
    end
  end

  private

  def already_liked?
    Like.for_user(current_user).for_gem(@gem).exists?
  end

  def set_gem
    @gem = Gemm.find(params[:gem_id] || params[:id])
  end

end