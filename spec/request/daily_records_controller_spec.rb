# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DailyRecords', type: :feature do
  before do
    15.times do |i|
      FactoryBot.create(:daily_record, date: Date.today - i.days)
    end
  end
  describe 'GET /daily_records' do
    it 'returns a success response' do
      visit daily_records_path
      expect(page).to have_http_status(:success)
    end

    it 'displays daily records' do
      visit daily_records_path
      expect(page).to have_content('Daily Record')
    end

    it 'paginates daily records' do
      visit daily_records_path
      expect(page).to have_selector('.pagination')
      click_link '2'
      expect(page).to have_selector('span.page.current', text: '2')
    end
  end
end
