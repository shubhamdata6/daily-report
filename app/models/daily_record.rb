class DailyRecord < ApplicationRecord
include ActiveModel::Dirty

  # Define the attributes you want to track
  # define_attribute_methods :male_count, :female_count

  before_save :calculate_average_ages, if: :gender_counts_changed?

  private

  def gender_counts_changed?
    male_count_changed? || female_count_changed?
  end

  def calculate_average_ages
    self.male_avg_age = User.male.average(:age).to_f
    self.female_avg_age = User.female.average(:age).to_f
  end
end
