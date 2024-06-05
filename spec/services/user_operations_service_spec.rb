# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserOperationsService, type: :service do
  let(:user_data) do
    {
      'login' => { 'uuid' => 'xyzabc' },
      'name' => { 'first' => 'John', 'last' => 'Doe' },
      'gender' => 'male',
      'dob' => { 'age' => 30 },
      'location' => {
        'city' => 'Kuršumlija',
        'state' => 'Kosovo',
        'street' => { 'name' => 'Matije Ambrožića', 'number' => 4344 },
        'country' => 'Serbia',
        'postcode' => 73_049,
        'timezone' => { 'offset' => '-3:30', 'description' => 'Newfoundland' },
        'coordinates' => { 'latitude' => '21.7560', 'longitude' => '122.4338' }
      }
    }
  end

  let(:service) { described_class.new(user_data) }
  # rubocop:disable Style/GlobalVars
  describe '#initialize' do
    it 'assigns correct attributes from user_data' do
      expect(service.identifier).to eq('xyzabc')
      expect(service.name).to eq('John Doe')
      expect(service.gender).to eq('male')
      expect(service.age).to eq(30)
      expect(service.location).to eq(user_data['location'])
    end
  end

  describe '#process' do
    it 'calls the necessary methods to process user data' do
      expect(service).to receive(:find_user_by_uuid)
      expect(service).to receive(:create_or_update_user)
      expect(service).to receive(:set_count_to_redis)
      service.process
    end
  end

  describe '#find_user_by_uuid' do
    it 'finds or initializes a user by uuid' do
      allow(User).to receive(:find_or_initialize_by).with(id: 'xyzabc').and_return(User.new)
      service.find_user_by_uuid
      expect(service.instance_variable_get(:@user)).to be_a(User)
    end
  end

  describe '#create_or_update_user' do
    let(:user) { User.new }

    before do
      allow(service).to receive(:find_user_by_uuid).and_return(user)
      service.find_user_by_uuid
      service.instance_variable_set(:@user, user)
    end

    it 'updates the user with the correct attributes' do
      expect(user).to receive(:update).with(
        name: 'John Doe',
        age: 30,
        gender: 'male',
        location: user_data['location']
      )
      service.create_or_update_user
    end
  end

  describe '#set_count_to_redis' do
    before do
      allow(User).to receive(:male).and_return(double(count: 5))
      allow(User).to receive(:female).and_return(double(count: 10))
      allow($redis).to receive(:set)
    end

    it 'sets male and female counts to Redis' do
      service.set_count_to_redis
      expect($redis).to have_received(:set).with('male_count', 5)
      expect($redis).to have_received(:set).with('female_count', 10)
    end
  end
end
# rubocop:enable Style/GlobalVars
