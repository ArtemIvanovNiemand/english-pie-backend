FactoryBot.define do
  factory :match_exercise do
    left_variants {%w(1 2 3 4 5)}
    right_variants {%w(e d c b a)}
    answer {%w(5 4 3 2 1)}
  end
end