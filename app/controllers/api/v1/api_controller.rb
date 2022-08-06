module Api
  module V1
    class ApiController < ApiBaseController
      include Concerns::Response
      include Concerns::ErrorHandler
    end
  end
end