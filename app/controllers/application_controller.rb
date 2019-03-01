class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(resource_or_scope)
    '/tasks'
  end

  def after_sign_up_path_for(resource_or_scope)
    '/users/sign_in'
  end

  def after_sign_out_path_for(resource_or_scope)
    '/'
  end
end
