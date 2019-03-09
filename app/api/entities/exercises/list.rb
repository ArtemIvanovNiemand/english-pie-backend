module Entities
  module Exercises
    class List < Grape::Entity
      expose :id
      expose :name
      expose :description
      expose :exercise_type
    end
  end
end