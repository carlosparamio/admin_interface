require 'digest/sha2'

class AdminController < ApplicationController
  layout 'admin'
  
  before_filter :authenticate
  
  protected
  
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      session[:admin] = username == AdminInterface::Config.username && Digest::SHA256.hexdigest(password) == AdminInterface::Config.password_digest
    end
  end
end