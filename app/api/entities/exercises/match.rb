module Entities
  module Exercises
    class Match < Grape::Entity
      expose :left_variants, as: :left
      expose :right_variants, as: :right
    end
  end
end