class DailyRecordJob < ApplicationJob
  queue_as :default

  def perform
    DailyRecordService.new.process
  end
end
