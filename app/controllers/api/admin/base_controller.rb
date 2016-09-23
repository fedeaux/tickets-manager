class Api::Admin::BaseController < Api::BaseController
  before_action :verify_admin!

  def verify_admin!
    unless current_user.admin?
      head 401
    end
  end
end
