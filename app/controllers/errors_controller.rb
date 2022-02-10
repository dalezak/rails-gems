class ErrorsController < ApplicationController

  def bad_request
    render(status: :bad_request)
  end

  def unknown_error
    render(status: :bad_request)
  end

  def route_not_found
    render(status: :not_found)
  end

  def resource_not_found
    render(status: :not_found)
  end

  def not_acceptable
    render(status: :not_acceptable)
  end

  def not_authorized
    render(status: :unprocessable_entity)
  end

  def internal_server_error
    render(status: :internal_server_error)
  end

  def service_unavailable
    render(status: :internal_server_error)
  end

end

