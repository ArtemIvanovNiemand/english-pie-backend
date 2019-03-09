class Exercise < ApplicationRecord
  belongs_to :lesson
  belongs_to :exercise, :polymorphic => true

  has_one :self_ref, :class_name => Exercise.name, :foreign_key => :id

  has_one :true_or_false_exercise,
          :through => :self_ref,
          :source => :exercise,
          :source_type => :TrueOrFalseExercise

  has_one :match_exercise,
          :through => :self_ref,
          :source => :exercise,
          :source_type => :MatchExercise

  has_one :choose_exercise,
          :through => :self_ref,
          :source => :exercise,
          :source_type => :ChooseExercise

  def linked_exercise
    case exercise_type
    when TrueOrFalseExercise.name
      true_or_false_exercise
    when ChooseExercise.name
      choose_exercise
    when MatchExercise.name
      match_exercise
    else
      raise ArgumentError('Wrong exercise type.')
    end
  end
end
