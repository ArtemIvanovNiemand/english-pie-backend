FactoryBot.define do
  factory :choose_exercise do
    variants {%w(0 1 2 3 42 5)}
    answer { 4 }
  end
end