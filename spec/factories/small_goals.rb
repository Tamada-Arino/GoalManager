FactoryBot.define do
  factory :small_goal do
    title { 'test_title' }
    achievable { false }

    association :goal
  end
end
