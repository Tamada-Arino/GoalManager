FactoryBot.define do
  factory :report do
    target_date { Time.zone.today }
    progress_value { 50 }
    content { 'test' }

    association :goal
  end
end
