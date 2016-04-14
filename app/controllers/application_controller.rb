require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery

  before_filter :authenticate_user!

  def block_readonly_users
    flash[:error] = "You are not allowed to access this page"
    redirect_to :root
  end
end
