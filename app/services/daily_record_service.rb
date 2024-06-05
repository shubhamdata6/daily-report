# frozen_string_literal: true

# app/services/daily_report_service.rb
class DailyRecordService
  attr_accessor :male_count, :female_count

  def initialize
    @male_count = $redis.get('male_count').to_i
    @female_count = $redis.get('female_count').to_i
  end

  def process
    find_daily_record
    update_daily_record
  end

  def find_daily_record
    @daily_record = DailyRecord.find_or_initialize_by(date: Date.today)
  end

  def update_daily_record
    @daily_record.update(
      male_count:,
      female_count:
    )
  end
end
