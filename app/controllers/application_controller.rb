require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery

  before_action :authenticate_user!


  before_action :block_readonly_users, only: [:new, :edit,  :update, :create]

  def block_readonly_users
    if current_user && current_user.read_only?
      flash[:error] = "You are not allowed to access this page"
      redirect_to :root
    end
  end
end
