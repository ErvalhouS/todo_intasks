# frozen_string_literal: true

# Controller to manage the landing page
class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  # GET /
  def index; end
end
