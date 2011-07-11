class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model
    auth = env["omniauth.auth"] 
    @user = User.find_for_facebook_oauth(env["omniauth.auth"], current_user)
    @authentication = @user.authentications.find_or_create_by_provider_and_uid(auth['provider'],auth['uid'])
    @authentication.update_attribute(:token,auth['credentials']['token'])
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.facebook_data"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
  
  # def twitter
  #   # You need to implement the method below in your model
  #   @user = User.find_for_twitter_oauth(env["omniauth.auth"], current_user)
  # 
  #   if @user.persisted?
  #     flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Twitter"
  #     flash[:notice] = env["omniauth.auth"]
  #     sign_in_and_redirect @user, :event => :authentication
  #   else
  #     session["devise.twitter_data"] = env["omniauth.auth"]
  #     redirect_to new_user_registration_url
  #   end
  # end
  
  
  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
  
  
end