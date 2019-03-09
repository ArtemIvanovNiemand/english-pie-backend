module Entities
  module Exercises
    class Checked < Base
      expose :info, merge: true do |base, options|
        user_answer = find_exercise_answer(options[:answers], base.id)

        exercise = base.linked_exercise
        correct = exercise.check(user_answer)

        {
            user_answer: user_answer,
            correct_answer: exercise.answer,
            correct: correct
        }
      end

      private

      def find_exercise_answer(answers, exercise_id)
        answers.find { |answer| exercise_id == answer[:id] }.try(:[], :answer)
      end
    end
  end
end