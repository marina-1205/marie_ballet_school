class Admin::ConfirmationsController < Devise::ConfirmationsController
  before_action :authenticate_admin!
end
