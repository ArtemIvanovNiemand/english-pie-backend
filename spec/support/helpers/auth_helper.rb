module Helpers
  module AuthHelper

    def api_headers
      {
          'HTTP_Content-Type' => 'application/json'
      }
    end

    def auth_headers(user)
      auth_token = JsonWebToken.encode(user_id: user.id)

      api_headers.merge(
          'HTTP_Authorization' => auth_token
      )
    end
  end
end