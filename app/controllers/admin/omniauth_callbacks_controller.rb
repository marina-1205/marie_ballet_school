class Admin::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :authenticate_admin!
end
