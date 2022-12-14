# frozen_string_literal: true

module Authable
  extend ActiveSupport::Concern

  included do
    skip_before_action :authorize!
  end

  def show
    return not_found unless current_member

    render json: {
      success: true,
      **::UserBlueprinter.render_as_hash(current_member, root: :user),
    }
  end

  def sign_in
    @current_member = resource.find_by(email: sign_in_params[:email], password: sign_in_params[:password])

    return not_found unless @current_member

    render json: {
      success: true,
      **::UserBlueprinter.render_as_hash(@current_member, root: :user),
    }, status: 200
  end

  def create
    @current_member = resource.new(user_params)
    @current_member.setup_token

    if @current_member.save
      render json: {
        success: true,
        **::UserBlueprinter.render_as_hash(@current_member, root: :user),
      }
    else
      render json: {
        success: false,
        errors: @current_member.errors,
      }, status: 400
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
      }, status: 400
    end
  end

  private

  def user_params
    params.permit(:email, :first_name, :last_name, :password)
  end

  def update_params
    params.permit(:email, :first_name, :last_name, :password, :bio, :age)
  end

  def sign_in_params
    @sign_in_params ||= params.permit(:email, :password)
  end

  def not_found(message = "Not Found")
    render json: { success: false, message: message }, status: :not_found
  end

  def resource
    User
  end
end
