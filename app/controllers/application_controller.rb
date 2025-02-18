class ApplicationController < ActionController::Base
  include Authentication
  include Pundit::Authorization

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  add_flash_types :alert

  before_action :require_authentication

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  # rails 8 default authorisation users Current.user instead of current_user
  def pundit_user
    Current.user
  end

  def user_not_authorized
    respond_to do |format|
      # TODO: flash[:alert] not working for some reason?
      format.html { redirect_back(fallback_location: root_path, notice: "Forbidden action") }
      format.json { render json: { error: "Forbidden action." }, status: :forbidden }
    end
  end
end
