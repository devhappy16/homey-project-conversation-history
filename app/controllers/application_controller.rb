class ApplicationController < ActionController::Base
  include Authentication
  include Pundit::Authorization

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :require_authentication

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    unauthorized_message = "Forbidden action."

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path, alert: unauthorized_message) }
      format.json { render json: { error: unauthorized_message }, status: :forbidden }
    end
  end
end
