RSpec.describe EmailProcessor do
  describe "#process" do
    context "without a valid user" do
      let(:user) { User.new }
      let(:email) do 
        build(:email, body: html, to: [{ 
          full: 'to_user@email.com', 
          email: 'to_user@email.com', 
          token: 'to_user', 
          host: 'email.com', 
          name: nil 
        }]) 
      end
      it "handles the error"
    end

    context "with a valid user" do
      let(:html) { file_fixture("skydemon.html").read }
      let(:user) { create(:user) }
      let(:email) do 
        build(:email, body: html, to: [{ 
          full: "#{user.skydemon_key}@example.com", 
          email: "#{user.skydemon_key}@email.com", 
          token: user.skydemon_key, 
          host: 'email.com', 
          name: nil 
        }]) 
      end
      it "imports the flights" do
        EmailProcessor.new(email).process
        expect(Flight.count).to eql(50)
      end

      it "does not duplicate the flights"  do
        expect(Flight.count).to eql(0)
        EmailProcessor.new(email).process
        expect(Flight.count).to eql(50)
        EmailProcessor.new(email).process
        expect(Flight.count).to eql(50)
      end

      context "with a single aircraft" do
        let(:user) { create(:user, aircraft: ["groly"]) }
        it "sets the tailnumber" do
          EmailProcessor.new(email).process
          expect(Flight.first.tail_number).to eql("groly")
        end
      end

      context "with multiple aircrafts" do
        let(:user) { create(:user, aircraft: ["groly", "gbuux"]) }
        it "sets the tailnumber" do
          EmailProcessor.new(email).process
          expect(Flight.first.tail_number).to eql("")
        end
      end
    end
  end
end
