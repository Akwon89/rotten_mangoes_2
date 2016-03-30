class Admin::AdminController < ApplicationController

  before_action :admin_only

  private

  def admin_only
    unless current_user && current_user.is_admin?
      redirect_to root_path
    end
  end

end