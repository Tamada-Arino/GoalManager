# frozen_string_literal: true

FactoryBot.define do
  factory :goal do
    title { 'test_title' }
    start_date { Time.zone.today }
    schedules_end_date { Time.zone.today + 1.day }
    end_date { Time.zone.today + 1.day }
    interrupted { false }
    color { '#ff0000' }

    association :user
  end
end
