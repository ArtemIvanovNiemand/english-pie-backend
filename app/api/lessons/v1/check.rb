module Lessons
  module V1
    module Check
      extend Grape::API::Helpers

      params :check do
        requires :id
        requires :answers, type: Array[JSON] do
          requires :id, type: Integer
          requires :answer,  types: [Integer, Boolean, Array[Integer]]
        end
      end

      def check
        unauthorized! unless authorized?
        p = declared(params)

        lesson = current_user
                     .group
                     .lessons
                     .includes_exercises
                     .find(p[:id])

        success(
            message: I18n.t("api.lessons.check.success"),
            data: {
                lesson: Entities::Lessons::Checked.represent(lesson, answers: p[:answers])
            }
        )
      end
    end
  end
end
