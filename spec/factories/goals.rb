FactoryBot.define do
  factory :goal do
    title { 'test_title' }
    start_date { Time.zone.today }
    schedule_end_date { Time.zone.today + 1.days }
    end_date {Time.zone.today + 1.days }
    interrupted { false }
    color { '#ff0000' }

    association :user
  end
end
