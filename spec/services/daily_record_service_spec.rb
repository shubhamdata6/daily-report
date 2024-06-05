# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DailyRecordService, type: :service do
  let(:redis) { double('Redis') }

  before do
    allow($redis).to receive(:get).with('male_count').and_return('5')
    allow($redis).to receive(:get).with('female_count').and_return('10')
  end

  let(:service) { DailyRecordService.new }

  describe '#initialize' do
    it 'assigns male and female counts from Redis' do
      expect(service.male_count).to eq(5)
      expect(service.female_count).to eq(10)
    end
  end

  describe '#process' do
    it 'calls the necessary methods to process the daily record' do
      expect(service).to receive(:find_daily_record)
      expect(service).to receive(:update_daily_record)
      service.process
    end
  end

  describe '#find_daily_record' do
    it 'finds or initializes a daily record by date' do
      allow(DailyRecord).to receive(:find_or_initialize_by).with(date: Date.today).and_return(DailyRecord.new)
      service.find_daily_record
      expect(service.instance_variable_get(:@daily_record)).to be_a(DailyRecord)
    end
  end

  describe '#update_daily_record' do
    let(:daily_record) { DailyRecord.new }

    before do
      allow(service).to receive(:find_daily_record).and_return(daily_record)
      service.find_daily_record
      service.instance_variable_set(:@daily_record, daily_record)
    end

    it 'updates the daily record with the correct male and female counts' do
      expect(daily_record).to receive(:update).with(
        male_count: 5,
        female_count: 10
      )
      service.update_daily_record
    end
  end
end
