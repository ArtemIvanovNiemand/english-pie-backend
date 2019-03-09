FactoryBot.define do
  factory :lesson do
    sequence :name do |id|
      "lesson_#{id}".downcase
    end

    description { "Lesson test description" }

    association :group, factory: :group
  end
end