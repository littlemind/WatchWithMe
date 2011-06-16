class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    
    redirect_to authentications_url
  end

end
