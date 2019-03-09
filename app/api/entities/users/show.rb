module Entities
  module Users
    class Show < Grape::Entity
      expose :first_name
      expose :last_name
      expose :email
      expose :access_level

      expose :auth_token do |user|
        JsonWebToken.encode(user_id: user.id)
      end
    end
  end
end