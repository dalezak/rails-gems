class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Exception, with: :unknown_error if Rails.env.production?
  rescue_from StandardError, with: :unknown_error
  rescue_from ActionController::RoutingError, with: :route_not_found
  rescue_from ActionController::UnknownFormat, with: :bad_request
  rescue_from ActionController::InvalidCrossOriginRequest, with: :bad_request
  rescue_from ActionController::InvalidAuthenticityToken, with: :bad_request
  rescue_from AbstractController::ActionNotFound, with: :route_not_found
  rescue_from ActionView::MissingTemplate, with: :bad_request
  rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found
  rescue_from ActiveRecord::RecordNotSaved, with: :not_acceptable
  rescue_from ActionController::RoutingError, with: :route_not_found
  rescue_from AbstractController::DoubleRenderError, with: :bad_request
  rescue_from CanCan::AccessDenied, with: :not_authorized

  def not_authorized(error)
    logger.error "not_authorized #{error}"
    respond_to do |format|
      format.html { render template: "errors/not_authorized", status: :unauthorized }
      format.json { render json: { error: "Not Authorized", status: 401 }, status: :unauthorized }
      format.all { render nothing: true, status: :unauthorized }
    end
  end

  def resource_forbidden(error)
    logger.error "resource_forbidden #{error}"
    respond_to do |format|
      format.html { render template: "errors/not_authorized", status: :forbidden }
      format.json { render json: { error: "Forbidden", status: 403 }, status: :forbidden }
      format.all { render nothing: true, status: :forbidden }
    end
  end

  def resource_not_found(error)
    logger.error "resource_not_found #{error}"
    respond_to do |format|
      format.html { render template: "errors/resource_not_found", status: :not_found }
      format.json { render json: { error: "Resource Not Found", status: 404 }, status: :not_found }
      format.all { render nothing: true, status: :not_found }
    end
  end

  def route_not_found(error)
    logger.error "route_not_found #{error}"
    respond_to do |format|
      format.html { render template: "errors/route_not_found", status: :not_found }
      format.json { render json: { error: "Route Not Found" }, status: :not_found }
      format.all { render nothing: true, status: :not_found }
    end
  end

  def unsupported_version(error)
    logger.error "unsupported_version #{error}"
    respond_to do |format|
      format.html { render template: "errors/unsupported_version", status: :not_found }
      format.json { render json: { error: "Unsupported Version", status: 404 }, status: :not_found }
      format.all { render nothing: true, status: :not_found }
    end
  end

  def not_acceptable(error)
    logger.error "not_acceptable #{error}"
    logger.error error.backtrace.join("\n") unless error.backtrace.nil?
    respond_to do |format|
      format.html { render template: "errors/not_acceptable", status: :not_acceptable }
      format.json { render json: { error: "Not Acceptable", status: 406 }, status: :not_acceptable }
      format.all { render nothing: true, status: :not_acceptable }
    end
  end

  def bad_request(error)
    logger.error "bad_request #{error}"
    logger.error error.backtrace.join("\n") unless error.backtrace.nil?
    respond_to do |format|
      format.html { render template: "errors/bad_request", status: :bad_request }
      format.json { render json: { error: "Bad Request", status: 400 }, status: :bad_request }
      format.all { render nothing: true, status: :bad_request }
    end
  end

  def unknown_error(error)
    logger.error "unknown_error #{error}"
    logger.error error.backtrace.join("\n") unless error.backtrace.nil?
    respond_to do |format|
      format.html { render template: "errors/unknown_error", status: :internal_server_error }
      format.json { render json: { error: "Unknown Error", status: 500 }, status: :internal_server_error }
      format.all { render nothing: true, status: :internal_server_error }
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :title, :image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :title, :image])
  end

end
