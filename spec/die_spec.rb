require "spec_helper"

RSpec.describe DiceGame::Die do
  describe ".build" do
    it "builds a die with given faces" do
      die = DiceGame::Die.build(faces: 8)
      expect(die.faces).to eq((1..8).to_a)
    end

    it "builds a die with stickers" do
      multiplier_sticker = DiceGame::Sticker::Multiplier.new(value: 3)
      die = DiceGame::Die.build(faces: 8, stickers: [multiplier_sticker])
      expect(die.faces.count).to eq(8)
      expect(die.faces).to include(multiplier_sticker)
    end
  end

  describe "#to_s with a multiplier sticker" do
    it "returns the string representation of the die" do
      multiplier_sticker = DiceGame::Sticker::Multiplier.new(value: 2)
      die = DiceGame::Die.build(faces: 6, stickers: [multiplier_sticker])
      expect(die.to_s).to eq("d6 (+1 x2)")
    end
  end

  describe "#add_sticker" do
    it "adds a sticker to the die" do
      die = DiceGame::Die.new
      sticker = DiceGame::Sticker::Addition.new(value: 5)
      die.add_sticker(sticker)
      expect(die.faces).to include(sticker)
      expect(die.faces.count).to eq(6)
    end
  end
end
