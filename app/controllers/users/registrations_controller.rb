class Users::RegistrationsController < Devise::RegistrationsController
    # PUT /resource
    # We need to use a copy of the resource because we don't want to change
    # the current user in place.
    
    #override update method to allow update without password and allow facebook-authenticated users to set a password
    #instructions can be found here http://www.communityguides.eu/articles/11
    def update
      self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
      
      
      if current_user.has_local_pw
         super
       else
         # this account has been created with a random pw / the user is signed in via an omniauth service
         # if the user does not want to set a password we remove the params to prevent a validation error
         if params[resource_name][:password].blank? 
           params[resource_name].delete(:password) 
           params[resource_name].delete(:password_confirmation) if params[resource_name][:password_confirmation].blank? 
         else
           # if the user wants to set a password we set haslocalpw for the future
           params[resource_name][:has_local_pw] = true
         end
         
        #copied from original devise file -> changed update_with_password to update_without_password
        if resource.update_attributes(params[resource_name])
          set_flash_message :notice, :updated if is_navigational_format?
          sign_in resource_name, resource, :bypass => true
          respond_with resource, :location => after_update_path_for(resource)
        else
          clean_up_passwords(resource)
          respond_with_navigational(resource){ render_with_scope :edit }
        end
      end
    end  

  
end