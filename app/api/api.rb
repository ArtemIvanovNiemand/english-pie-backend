require 'grape'

class API < Grape::API
  prefix :api
  format :json

  helpers APIHelpers
  helpers AuthHelpers

  rescue_from ActiveRecord::RecordNotFound do |error|
    ErrorsLogger.new.call(error)

    not_found!
  end

  rescue_from :all do |error|
    ErrorsLogger.new.call(error)

    server_error!
  end

  mount Users::V1::Endpoints
  mount Lessons::V1::Endpoints
end
