class User < ApplicationRecord
  enum :gender, { male: 'male', female: 'female' }

  after_destroy :update_male_or_female_count

  private

  def update_male_or_female_count
    daily_record = DailyRecord.find_or_initialize_by(date: Date.today)
    daily_record.update(male_count: User.male.count, female_count: User.female.count)
  end
end
