module Lessons
  module V1
    module Show
      extend Grape::API::Helpers

      params :show do
        requires :id
      end

      def show
        unauthorized! unless authorized?

        p = declared(params)

        lesson = current_user
                     .group
                     .lessons
                     .includes_exercises
                     .find(p[:id])

        success(
          message: I18n.t("api.common.show", model_name: Lesson.model_name.human),
          data: {
              lesson: Entities::Lessons::Show.represent(lesson)
          }
        )
      end
    end
  end
end
