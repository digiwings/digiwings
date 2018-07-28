RSpec.describe Skydemon do
  describe "self.import" do
    context "with valid input" do
      let(:html) { file_fixture("skydemon.html").read }
      let(:result) { described_class.import(html) }
      it "is valid with valid attributes" do
        expect(result.length).to eql(50)
        expect(result.first.tail_number).to eql("")
      end
    end
  end
end
