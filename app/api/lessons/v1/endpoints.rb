module Lessons
  module V1
    class Endpoints < Grape::API
      version "v1", using: :path

      helpers Lessons::V1::List
      helpers Lessons::V1::Show
      helpers Lessons::V1::Check

      resource :lessons do
        get("/") { list }

        params { use :show }
        get("/:id") { show }

        params { use :check }
        post("/:id") { check }
      end
    end
  end
end
