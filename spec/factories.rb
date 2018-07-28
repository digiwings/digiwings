FactoryBot.define do
  factory :airfield do
    icao { (0...4).map { ('A'..'Z').to_a[rand(26)] }.join }
    city { Faker::Address.city }
    country { Faker::Address.country_code }
    tz { TZInfo::Timezone.all.map(&:name).sample }
    lat { Faker::Address.latitude }
    lon { Faker::Address.longitude }
    elevation { Faker::Number.between(0, 1000) }
  end
end
