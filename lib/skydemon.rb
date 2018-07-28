class Skydemon
  def self.import(html)
    document = Nokogiri::HTML(html)
    table = document.at('table')
    res = ""
    table.search('tr').each do |tr|
      cells = tr.search('th, td')
      # text = cell.text.strip
      res << CSV.generate_line(cells)
    end
    CSV.parse(res, headers: :first_row).map(&:to_h).map { |h| self.flight_from_hash(h)}
  end

  def self.flight_from_hash(h)
    parts = h["Log Name"].split("-").map(&:strip!)
    actual_departure_time = DateTime.strptime(
      h["Log Start"],
      "%Y/%m/%d %H:%M"
    )

    actual_arrival_time = DateTime.strptime(
      h["Log Stop"],
      "%Y/%m/%d %H:%M"
    )

    Flight.new({
      tail_number: "",
      origin_icao: self.get_airfield_icao_from_location(parts[0]),
      destination_icao: self.get_airfield_icao_from_location(parts[1]),
      actual_departure_time: actual_departure_time,
      actual_arrival_time: actual_arrival_time
    })
  end

  def self.get_airfield_icao_from_location(location)
    a = Airfield.search_full_text(parse_location_string(location)).first 
    if a.present?
      return a.icao
    end
    location.split(")").last.strip
  end

  def self.parse_location_string(location)
      x = /^\((.*)\snm\)(.*)$/.match(location)
      return location unless x.present?
      return x[1]
  end
end
