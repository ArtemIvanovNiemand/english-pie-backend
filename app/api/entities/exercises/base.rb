module Entities
  module Exercises
    class Base < Grape::Entity
      expose :id
      expose :name
      expose :description
      expose :exercise_type

      expose :info,
             merge: true,
             if: lambda { |exercise| exercise.exercise_type == MatchExercise.name },
             using: Entities::Exercises::Match do |exercise|
        exercise.match_exercise
      end

      expose :info,
             merge: true,
             if: lambda { |exercise| exercise.exercise_type == ChooseExercise.name },
             using: Entities::Exercises::Choose do |exercise|
        exercise.choose_exercise
      end
    end
  end
end