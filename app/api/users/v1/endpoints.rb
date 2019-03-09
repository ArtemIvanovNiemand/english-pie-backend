module Users
  module V1
    class Endpoints < Grape::API
      version %w[admin.v1 v1], using: :path

      helpers CreateSession
      helpers Create
      helpers Me

      resource :users do
        get("/me") { me }

        params { use :create_session }
        post("/session") { create_session }

        params { use :create }
        post("/") { create }
      end
    end
  end
end
