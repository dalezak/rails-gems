class OmniauthController < Devise::OmniauthCallbacksController
  
  def github
    @user = User.from_omniauth request.env["omniauth.auth"]
    if @user.present?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: "Github"
      sign_in_and_redirect root_url, event: :authentication
    else
      redirect_to root_url, alert: "Unable to sign in via Github"
    end
  end  

end
