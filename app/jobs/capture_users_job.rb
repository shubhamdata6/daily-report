# frozen_string_literal: true

# Job to fetch users from 'https://randomuser.me/api/?results=20'
class CaptureUsersJob < ApplicationJob
  queue_as :default

  def perform
    fetch_users
    @users.each do |user_data|
      UserOperationsService.new(user_data).process
    end
  end

  def fetch_users
    response = Faraday.get('https://randomuser.me/api/?results=20')
    @users = JSON.parse(response.body)['results']
  end
end
