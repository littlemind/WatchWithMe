class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    
    redirect_to edit_user_registration_path
  end

end
