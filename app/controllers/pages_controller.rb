class PagesController < ApplicationController

  def index
    @users = User.limit(12).order(likes_count: :desc, name: :asc)
    @gems = Gemm.with_tags(true).limit(12).order(likes_count: :desc, name: :asc)
  end

end
