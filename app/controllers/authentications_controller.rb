class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    if current_user.has_local_pw
      @authentication.destroy
      flash[:notice] = "Authentication succsessfull removed."
    else
      flash[:notice] = "You musst assign a password first."
    end
    redirect_to edit_user_registration_path
  end

end
