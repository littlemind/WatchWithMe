class Users::RegistrationsController < Devise::RegistrationsController
  
  # GET /resource/edit
  def edit
    @user = current_user
    render_with_scope :edit
  end
  
end