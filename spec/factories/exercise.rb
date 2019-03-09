FactoryBot.define do
  factory :exercise do
    name { "Test exercise" }
    description { "Test description" }
    association :lesson, factory: :lesson

    sequence :sort_order do |id|
      id
    end

    trait :true_or_false do
      name { "Test true or false exercise" }
      association :exercise, factory: :true_or_false_exercise
    end

    trait :choose do
      name { "Test choose exercise" }
      association :exercise, factory: :choose_exercise
    end

    trait :match do
      name { "Test match exercise" }
      association :exercise, factory: :match_exercise
    end
  end
end