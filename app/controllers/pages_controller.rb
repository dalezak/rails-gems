class PagesController < ApplicationController
  
  def index
    query = Gemm.for_search("")
    @gems = query.limit(24).offset(0).order(likes_count: :desc)
    @gems_count = query.count(:all) if request.format.html?
    if user_signed_in?
      @likes = Like.for_user(current_user).for_gems(@gems).all
      @gems.each do |gem|
        gem.liked = @likes.any? {|like| like.gem_id == gem.id }
      end
    end
  end

end
