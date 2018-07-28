RSpec.describe Skydemon do
  describe "self.import" do
    context "with valid input" do
      let(:html) { file_fixture("skydemon.html").read }
      let(:result) { described_class.import(html) }
      let!(:nethers) { create(:airfield, name: "Netherthorpe Airfield", icao:"EGNF")}
      let!(:sherburn) { create(:airfield, name: "Sherburn In Elmet", icao:"EGCJ")}
      let!(:wickenby) { create(:airfield, name: "Wickenby Aerodrome", icao:"EGNW")}
      let!(:gamston) { create(:airfield, name: "Retford Gamston Airport", icao:"EGNE")}
      let!(:oban) { create(:airfield, name: "Oban Airport", icao:"EGEO")}
      let!(:nottingham) { create(:airfield, name: "Nottingam Airport", icao:"EGBN")}
      let!(:fenland) { create(:airfield, name: "Fenland Airfield", icao:"EGCL")}
      let!(:skegness) { create(:airfield, name: "Skegness (Ingoldmells) Aerodrome", icao:"EGNI")}
      let!(:sywell) { create(:airfield, name: "Sywell Aerodrome", icao:"ENBK")}

      it "is valid with valid attributes" do
        expect(result.length).to eql(50)
        expect(result.first.tail_number).to eql("")
        expect(result[1].origin_icao).to eql("EGCJ")
        expect(result[1].destination_icao).to eql("EGNF")
        expect(result[1].actual_departure_time.to_i).to eql(DateTime.strptime("2018-07-03 17:11 UTC", "%Y-%m-%d %H:%M %z").to_i)
        expect(result[1].actual_arrival_time.to_i).to eql(DateTime.strptime("2018-07-03 17:58 UTC", "%Y-%m-%d %H:%M %z").to_i)
      end

      it "handles unfindable airfields"
    end
  end
end
