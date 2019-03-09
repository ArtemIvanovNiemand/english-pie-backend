module Users
  module V1
    module Create
      extend Grape::API::Helpers

      params :create do
        requires :first_name, type: String
        requires :last_name, type: String
        requires :email, type: String
        requires :password, type: String
        requires :group_token, type: String
      end

      def create
        p = declared(params)

        check_email_uniqueness!(p)

        group = Group.find_by!(token: p[:group_token])
        check_group!(group)

        user = User.create!(
            first_name: p[:first_name],
            last_name: p[:last_name],
            email: p[:email],
            password: p[:password],
            group: group,
            access_level: :student
        )

        success(
            message: I18n.t("api.users.create.success"),
            data: {
                user: Entities::Users::Show.represent(user)
            }
        )
      end

      private

      def check_email_uniqueness!(p)
        bad_request! I18n.t("api.users.create.error.email_used") if User.exists?(email: p[:email])
      end

      def check_group!(group)
        bad_request! I18n.t("api.users.create.error.invalid_group") unless group
      end
    end
  end
end