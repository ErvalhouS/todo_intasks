# frozen_string_literal: true

# Controller to common users interaction with users
class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user

  # PATCH/PUT /users/1
  def update
    respond_to do |format|
      if @user.update(user_params)
        @categories = @user.categories
        format.js {}
        format.any { render json: @user.includes(:categories), status: :created }
      else
        format.any { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(categories_attributes: [:title])
  end
end
