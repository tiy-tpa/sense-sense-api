class ApplicationController < ActionController::API
  before_action :authenticate!

  protected

  def authenticate!
    render json: { errors: "Not Authorized" }, status: :unauthorized unless current_user.present?
  end

  def current_user
    @current_user ||= User.find_or_create_by! access_token: params[:access_token]
  end
end
