module Users
  module V1
    module Me
      extend Grape::API::Helpers

      def me
        unauthorized! unless authorized?

        success(
            message: I18n.t("api.users.me.success"),
            data: {
                user: Entities::Users::Show.represent(current_user)
            }
        )
      end
    end
  end
end
