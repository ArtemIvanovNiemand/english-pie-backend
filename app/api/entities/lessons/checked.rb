module Entities
  module Lessons
    class Checked < List
      expose :exercises, using: Entities::Exercises::Checked
    end
  end
end