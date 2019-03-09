module Entities
  module Lessons
    class List < Grape::Entity
      expose :id
      expose :name
      expose :description
    end
  end
end