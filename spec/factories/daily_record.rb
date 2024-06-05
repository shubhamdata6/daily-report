# frozen_string_literal: true

FactoryBot.define do
  factory :daily_record do
    date { Date.today }
    male_count { 1 }
    female_count { 2 }
    male_avg_age { nil }
    female_avg_age { nil }
  end
end
