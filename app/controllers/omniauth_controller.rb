class OmniauthController < Devise::OmniauthCallbacksController

  def github
    auth = request.env["omniauth.auth"]
    @user = User.from_omniauth(auth)
    if @user.present?
      @user.slug = auth.info.nickname
      @user.name = auth.info.name
      @user.image_remote_url = auth.info.image
      @user.homepage_uri = auth.info.urls["Blog"] if auth.info.urls["Blog"].present?
      @user.github_uri = auth.info.urls["GitHub"] if auth.info.urls["GitHub"].present?
      @user.save if @user.changed?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: "Github"
      sign_in(resource_name, @user)
      redirect_to root_url, event: :authentication
    else
      redirect_to root_url, alert: "Unable to sign in via Github"
    end
  end

end
