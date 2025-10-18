require "spec_helper"

RSpec.describe DiceGame::Game do
  describe "#roll" do
    it "rolls all dice and returns the total" do
      game = DiceGame::Game.new
      expect(game.score).to eq(0)
      game.roll!
      expect(game.score).to be > 0
    end
  end

  describe "add_upgrade" do
    it "adds a new die to the game" do
      game = DiceGame::Game.new
      initial_die_count = game.dice.count
      new_die = game.add_upgrade(:add_die)
      expect(game.dice.count).to eq(initial_die_count + 1)
      expect(new_die).to be_a(DiceGame::Die)
    end

    it "adds a sticker to a random die" do
      game = DiceGame::Game.new
      die = game.dice.first
      initial_sticker_count = die.faces.count { |face| face.is_a?(DiceGame::Sticker) }
      sticker = game.add_upgrade(:add_sticker)
      updated_sticker_count = die.faces.count { |face| face.is_a?(DiceGame::Sticker) }
      expect(updated_sticker_count).to be >= initial_sticker_count
      expect(sticker).to be_a(DiceGame::Sticker)
    end
  end
end
