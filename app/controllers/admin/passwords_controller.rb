class Admin::PasswordsController < Devise::PasswordsController
  before_action :authenticate_admin!
end
