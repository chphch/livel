class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      # sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      sign_in(@user, scope: :user)
      set_flash_message(:notice, :signed_in, scope: "devise.sessions") if is_navigational_format?

      # TODO refactor these parts, render_by_device is not working well
      if browser.device.mobile?
        render 'devise/sessions/successful_login_mobile'
      else
        render 'devise/sessions/successful_login_desktop'
      end
    else
      # TODO When is this exception-handling-block executed?
      puts "===============FACEBOOK LOGIN ERROR================="
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   redirect_to root_path
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
