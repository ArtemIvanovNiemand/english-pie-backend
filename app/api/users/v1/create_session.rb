module Users
  module V1
    module CreateSession
      extend Grape::API::Helpers

      params :create_session do
        requires :email, type: String
        requires :password, type: String
      end

      def create_session
        p = declared(params)

        user = User.find_by(email: p[:email])

        check_email!(user)
        check_password!(user, p[:password])

        success(
          message: I18n.t("api.users.session.success"),
          data: {
              user: Entities::Users::Show.represent(user)
          }
        )
      end

      def check_email!(user)
        bad_request! I18n.t("api.users.session.error.invalid_email_or_password") unless user
      end

      def check_password!(user, password)
        unless user.authenticate(password)
          bad_request! I18n.t("api.users.session.error.invalid_email_or_password")
        end
      end
    end
  end
end