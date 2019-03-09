module Entities
  module Lessons
    class Show < List
      expose :exercises, using: Entities::Exercises::Base
    end
  end
end