class MatchExercise < ApplicationRecord
  include Checkable

  validate :validate_answer

  def validate_answer
    if left_variants.empty? || left_variants.size != right_variants.size
      errors.add(:left_variants, 'Variants incorrect format')
    end

    if answer.uniq.size != left_variants.size
      errors.add(:answer, 'Answer incorrect format')
    end
  end
end