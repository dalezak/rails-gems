class OmniauthController < Devise::OmniauthCallbacksController

  def github
    auth = request.env["omniauth.auth"]
    @user = User.from_omniauth(auth)
    if @user.present?
      @user.slug = auth.info.nickname
      @user.name = auth.info.name
      @user.image_remote_url = auth.info.image
      @user.title = auth.extra.raw_info.bio
      @user.location = auth.extra.raw_info.location
      @user.homepage_uri = auth.extra.raw_info.blog if auth.extra.raw_info.blog.present?
      @user.github_uri = "https://github.com/#{auth.info.nickname}"
      @user.save if @user.changed?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: "Github"
      sign_in(resource_name, @user)
      redirect_to root_url, event: :authentication
    else
      redirect_to root_url, alert: "Unable to sign in via Github"
    end
  end

end
