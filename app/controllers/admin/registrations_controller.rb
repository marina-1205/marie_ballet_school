class Admin::RegistrationsController < Devise::RegistrationsController
   before_action :authenticate_admin!
   
   def configure_account_update_params
     devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
   end
end
