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
    origin_str = parts[0]
    dest_str = parts[0]
    if parts[0] == "("
    end

    Flight.new({
      tail_number: ""
    })
  end
end
