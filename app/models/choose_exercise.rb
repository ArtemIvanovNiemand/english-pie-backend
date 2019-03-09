class ChooseExercise < ApplicationRecord
  include Checkable

  has_one :exercise, as: :exercise
  has_one :lesson, through: :exercises

  validate :validate_answer

  def validate_answer
    unless (0...variants&.size).cover?(answer)
      errors.add(:answer, 'Answer out of range')
    end
  end
end
