module Entities
  module Exercises
    class Base < Grape::Entity
      expose :id
      expose :name
      expose :description
      expose :exercise_type

      expose :info,
             merge: true,
             if: lambda {|exercise, options| exercise.exercise_type == 'MatchExercise'},
             using: Entities::Exercises::Match do |exercise, options|
        exercise.match_exercise
      end

      expose :info,
             merge: true,
             if: lambda {|exercise, options| exercise.exercise_type == 'ChooseExercise'},
             using: Entities::Exercises::Choose do |exercise, options|
        exercise.choose_exercise
      end
    end
  end
end