class DailyRecordsController < ApplicationController
  def index
    @daily_records = DailyRecord.all.page(params[:page]).per(10)
  end
end
