class PagesController < ApplicationController

  def index
    @users = User.limit(12).order(likes_count: :desc)
    @gems = Gemm.for_search("").limit(12).order(likes_count: :desc)
    if user_signed_in?
      @likes = Like.for_user(current_user).for_gems(@gems).all
      @gems.each do |gem|
        gem.liked = @likes.any? {|like| like.gem_id == gem.id }
      end
    end
  end

end
