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

  factory :email, class: OpenStruct do
    # Assumes Griddler.configure.to is :hash (default)
    to [{ full: 'to_user@email.com', email: 'to_user@email.com', token: 'to_user', host: 'email.com', name: nil }]
    from({ token: 'from_user', host: 'email.com', email: 'from_email@email.com', full: 'From User <from_user@email.com>', name: 'From User' })
    subject 'email subject'
    body 'Hello!'
    attachments {[]}
  end

  factory :user do
    email { Faker::Internet.email }
    password { "password" }
  end
end
