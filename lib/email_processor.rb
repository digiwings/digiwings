class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    puts @email.inspect
  end
end
