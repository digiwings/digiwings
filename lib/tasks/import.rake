require "flightaware"
require 'upsert/active_record_upsert'

namespace :import do
  desc "Import Data from Flightaware"
  task flightaware: :environment do 
    User.select(:aircraft).map { |u| u.aircraft }.flatten.uniq.each do |aircraft|
      FlightAware.get_flights(aircraft).each do |flight|
        attrs = flight.attributes
        attrs.delete("id")
        attrs["created_at"] = DateTime.now
        attrs["updated_at"] = DateTime.now
        Flight.upsert({:fa_flight_id => flight.fa_flight_id}, attrs)
      end
      sleep 2
    end
  end
end
