# frozen_string_literal: true

module Authable
  extend ActiveSupport::Concern

  def sign_in
    return not_found unless current_member

    render json: {
      success: true,
      **::UserBlueprinter.render_as_hash(current_member, root: :user),
    }
  end

  def create
    @user = resource.new(user_params)
    @user.setup_token

    if @user.save
      render json: {
        success: true,
        **::UserBlueprinter.render_as_hash(@user, root: :user),
      }
    else
      render json: {
        success: false,
        errors: @user.errors,
      }
    end
  end

  def update
    current_member.assign_attribute(update_params)

    if current_member.save
      render json: {
        success: true,
        **::UserBlueprinter.render_as_hash(current_member, root: :user),
      }
    else
      render json: {
        success: false,
        errors: current_member.errors,
      }
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name).dup.tap do |hash|
      hash[:encrypted_password] = params[:user].require(:password)
      hash[:email] = params[:user].require(:email)
    end
  end

  def update_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :bio, :age)
  end

  def current_member
    @current_member ||= resource.find_by(auth_token: params[:auth_token])
  end

  def not_found(message = "Not Found")
    respond_to do |format|
      format.json do
        render json: { success: false, message: message }, status: :not_found
      end
    end
  end

  def resource
    User
  end
end
