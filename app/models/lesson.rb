class Lesson < ApplicationRecord
  belongs_to :group

  has_many :exercises, dependent: :destroy
  has_many :true_or_false_exercises, :through => :exercises, :source => :exercise, :source_type => TrueOrFalseExercise.name
  has_many :choose_exercises, :through => :exercises, :source => :exercise, :source_type => ChooseExercise.name
  has_many :match_exercises, :through => :exercises, :source => :exercise, :source_type => MatchExercise.name

  scope :includes_exercises, -> {
    includes(
        :true_or_false_exercises,
        :match_exercises,
        :choose_exercises
    )
  }
end
