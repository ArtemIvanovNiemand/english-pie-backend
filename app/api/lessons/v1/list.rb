module Lessons
  module V1
    module List
      extend Grape::API::Helpers

      def list
        unauthorized! unless authorized?

        lessons = current_user&.group&.lessons.order(:sort_order)

        success(
          message: I18n.t("api.common.show", model_name: Lesson.model_name.human),
          data: {
              lessons: Entities::Lessons::List.represent(lessons)
          }
        )
      end
    end
  end
end
