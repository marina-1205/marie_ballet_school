class Admin::UnlocksController < Devise::UnlocksController
  before_action :authenticate_admin!
end
