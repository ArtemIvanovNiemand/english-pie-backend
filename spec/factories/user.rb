FactoryBot.define do
  factory :user do
    first_name { "Joe" }
    last_name { "Blow" }
    sequence :email do |id|
      "#{first_name}.#{last_name}_#{id}@example.com".downcase
    end

    password { "#{first_name}.#{last_name}_password".downcase }

    trait :student do
      access_level { :student }
      group { association :group }
    end

    trait :admin do
      access_level { :admin }
      group { nil }
    end
  end
end
