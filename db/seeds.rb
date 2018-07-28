Airfield.delete_all
file = File.join(Rails.root, 'db', 'data', 'airports.json')
records = JSON.parse(File.read(file))
records.each do |record|
  Airfield.create!(record.last)
end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
