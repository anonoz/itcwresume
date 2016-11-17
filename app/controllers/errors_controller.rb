class ErrorsController < ApplicationController
  layout 'layouts/error'

  def not_found
    @title = "404 Not Found - ITCW Resume"
    render status: 404
  end

  def internal_server_error
    @title = "500 Internal Server Error - ITCW Resume"
    render status: 500
  end
end
