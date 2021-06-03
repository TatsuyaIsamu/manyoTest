class ApplicationController < ActionController::Base
  before_action :basic_authenticate
  frozen-ridge-21145
  def basic_authenticate

    authenticate_or_request_with_http_basic do |name, password|
      name == ENV['BASIC_AUTH_NAME'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end
end

