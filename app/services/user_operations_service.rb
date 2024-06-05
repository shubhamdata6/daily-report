# frozen_string_literal: true

# app/services/user_operations_service.rb
class UserOperationsService
  attr_accessor :identifier, :name, :age, :gender, :location

  def initialize(user_data)
    @identifier = user_data['login']['uuid']
    @name = "#{user_data['name']['first']} #{user_data['name']['last']}"
    @gender = user_data['gender']
    @age = user_data['dob']['age']
    @location = user_data['location']
  end

  def process
    find_user_by_uuid
    create_or_update_user
    set_count_to_redis
  end

  def find_user_by_uuid
    @user = User.find_or_initialize_by(id: identifier)
  end

  def create_or_update_user
    @user.update(
      name:,
      age:,
      gender:,
      location:
    )
  end

  def set_count_to_redis
    $redis.set('male_count', User.male.count)
    $redis.set('female_count', User.female.count)
  end
end
