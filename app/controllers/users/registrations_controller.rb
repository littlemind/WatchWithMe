class Users::RegistrationsController < Devise::RegistrationsController
  
  # GET /resource/edit
  def edit
    @authentications = current_user.authentications
    render_with_scope :edit
  end
  
end