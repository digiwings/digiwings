require 'upsert/active_record_upsert'
class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    flights = Skydemon.import(@email.body)
    user = User.find_by!(skydemon_key: @email.to[0][:token])

    flights.each do  |f|
      f.user_id = user.id
      attrs = f.attributes
      attrs.delete("id")
      attrs["created_at"] = DateTime.now
      attrs["updated_at"] = DateTime.now
      if user.aircraft.length == 1 
        attrs[:tail_number] = user.aircraft.first
      end
      Flight.upsert({user_id:user.id, actual_departure_time:f.actual_departure_time}, attrs)
    end
  end
end
