require File.join(File.dirname(__FILE__), 'spotted_dog')

describe SpottedDog do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      SpottedDog.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end
    describe "Conjured" do
      it "items degrade in Quality twice as fast as normal" do
        items = [
          Item.new("Normal", 5, 10),
          Item.new("Conjured", 5, 10)
        ]
        SpottedDog.new(items).update_quality()
        expect(items[0].quality).to eq 9
        expect(items[1].quality).to eq 8
      end
      it "shouldn't allow Quality to go below 0" do
        items = [
          Item.new("Conjured", 5, 1)
        ]
        SpottedDog.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end
    end
  end

end
