class TrueOrFalseExercise < ApplicationRecord
  include Checkable

  has_one :exercise, :as =>:exercise
  has_one :lesson, :through => :exercises
end
