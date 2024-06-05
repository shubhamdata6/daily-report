# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name  { Faker::Internet.email }
    age { Faker::Number.number(digits: 2) }
    gender { 'male' }
    location do
      {
        'city' => 'Kuršumlija',
        'state' => 'Kosovo',
        'street' => { 'name' => 'Matije Ambrožića ', 'number' => 4344 },
        'country' => 'Serbia',
        'postcode' => 73_049,
        'timezone' => { 'offset' => '-3:30', 'description' => 'Newfoundland' },
        'coordinates' => { 'latitude' => '21.7560', 'longitude' => '122.4338' }
      }
    end
  end
end
