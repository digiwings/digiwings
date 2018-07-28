require 'net/http'

class FlightAware
  def self.get_flights(tail_number)
    uri = URI::HTTP.build(
      [
        nil, 
        "flightxml.flightaware.com", 
        nil, 
        "/json/FlightXML3/FlightInfoStatus",
        "ident=#{tail_number.upcase}", 
        nil]
    )
    req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
    req.basic_auth("awsmsrc", Rails.application.credentials[:flightaware_key])

    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end

    if res.body.present? 
      json = JSON.parse(res.body)
      if json["FlightInfoStatusResult"].present?
        return json["FlightInfoStatusResult"]["flights"].map { |f| self.parse(f) }
      end
    end

    []
  end

  def self.parse(json)
    f = Flight.new
    f.fa_flight_id = json["faFlightID"]
    f.tail_number = json["tailnumber"]
    f.blocked = json["blocked"]
    f.diverted = json["diverted"]
    f.cancelled = json["cancelled"]
    f.actual_departure_time = DateTime.strptime(
      "#{json["actual_departure_time"]["date"]} #{json["actual_departure_time"]["time"]} #{json["actual_departure_time"]["tz"]}",
      "%m/%d/%Y %H:%M%p %z"
    )
    f.actual_arrival_time = DateTime.strptime(
      "#{json["actual_arrival_time"]["date"]} #{json["actual_arrival_time"]["time"]} #{json["actual_arrival_time"]["tz"]}",
      "%m/%d/%Y %H:%M%p %z"
    )

    origin_lat = json["origin"]["code"].split(" ")[1]
    origin_lon = json["origin"]["code"].split(" ")[2]
    origin_airfield = Airfield.by_distance(origin: [origin_lat, origin_lon]).limit(1).first
    if origin_airfield.present?
      f.origin_icao = origin_airfield.icao
    else
      f.origin_icao = json["origin"]["airport_name"]
    end

    destination_lat = json["destination"]["code"].split(" ")[1]
    destination_lon = json["destination"]["code"].split(" ")[2]
    destination_airfield = Airfield.by_distance(origin: [destination_lat, destination_lon]).limit(1).first
    if destination_airfield.present?
      f.destination_icao = destination_airfield.icao
    else
      f.destination_icao = json["destination"]["airport_name"]
    end
    f
  end
end
