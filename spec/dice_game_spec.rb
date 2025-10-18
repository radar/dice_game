# frozen_string_literal: true

RSpec.describe DiceGame do
  it "has a version number" do
    expect(DiceGame::VERSION).not_to be nil
  end

  it "calculates a total score with given roll" do
    game = DiceGame.new
    # 1 + 3 + 4 + 5 + 6 = 19
    expect(game.calculate(1, 3, 4, 5, 6)).to eq(19)
  end

  it "calculates a total score with a pair" do
    game = DiceGame.new
    expect(game.calculate(2, 2, 4, 5, 6)).to eq(29) # 2 + 2 + 4 + 5 + 6 + 10 (pair bonus)
  end

  it "calculates a total score with multiple pairs" do
    game = DiceGame.new
    # 3 + 3 + 5 + 5 + 1 = 17 + 20 (pair bonus x 2)
    expect(game.calculate(3, 3, 5, 5, 1)).to eq(37)
  end

  it "calculates a total score with a triple" do
    game = DiceGame.new
    # 4 + 4 + 4 + 2 + 1 = 15 + 20 (triple bonus)
    expect(game.calculate(4, 4, 4, 2, 1)).to eq(35)
  end

  it "calculates a total score with a quad" do
    game = DiceGame.new
    # 6 + 6 + 6 + 6 + 3 = 27 + 40 (quad bonus)
    expect(game.calculate(6, 6, 6, 6, 3)).to eq(67)
  end

  it "calculates a total score with a straight" do
    game = DiceGame.new
    # 1 + 2 + 3 + 4 + 5 + 30 (straight bonus) = 45
    expect(game.calculate(1, 2, 3, 4, 5)).to eq(45)
    # 1 + 2 + 2 + 2 + 5 = 12 + 20 (triple bonus)
    expect(game.calculate(1, 2, 2, 2, 5)).to eq(32)
  end

  it "calculates a score with a straight + six die" do
    game = DiceGame.new
    # 1 + 2 + 3 + 4 + 5 + 6 + 30 (straight bonus) = 51
    expect(game.calculate(5, 3, 2, 6, 1, 4)).to eq(51)
  end

  it "calculates fives" do
    game = DiceGame.new
    # (1 + 1 + 2 + 1 + 1 + 1) = 7 + 50 (five bonus) = 57
    expect(game.calculate(1, 1, 2, 1, 1, 1)).to eq(57)
  end

  it "calculates sixes" do
    game = DiceGame.new
    # (2 + 2 + 2 + 2 + 2 + 2) = 12 + 100 (six bonus) = 112
    expect(game.calculate(2, 2, 2, 2, 2, 2)).to eq(112)
  end

  it "calculates a total score including a multiplier sticker" do
    game = DiceGame.new
    sticker = DiceGame::Sticker::Multiplier.new(value: 2)
    # (1 + 3 + 4 + 4 + 5) (17) + pair bonus (10) = 27 * 2 = 54
    expect(game.calculate(1, 3, 4, 4, 5, sticker)).to eq(54)
  end

  it "calculates a total using an addition sticker and a multiplier sticker" do
    game = DiceGame.new
    multiplier_sticker = DiceGame::Sticker::Multiplier.new(value: 3)
    addition_sticker = DiceGame::Sticker::Addition.new(value: 10)

    expect(game.calculate(2, 2, 3, 4, addition_sticker, multiplier_sticker)).to eq(93)
  end

  it "calculates 5x sixes and a 2x multiplier sticker" do
    game = DiceGame.new
    sticker = DiceGame::Sticker::Multiplier.new(value: 2)
    # (6 + 6 + 6 + 6 + 6) (30) + five bonus (50) = 80 * 2 = 160
    expect(game.calculate(6, 6, 6, 6, 6, sticker)).to eq(160)
  end

  it "calculates 6, 6, 6, 6, 6, 6, 6, x2" do
    game = DiceGame.new
    sticker = DiceGame::Sticker::Multiplier.new(value: 2)
    # (6 + 6 + 6 + 6 + 6 + 6 + 6) (42) + six bonus (100) = 142 * 2 = 284
    expect(game.calculate(6, 6, 6, 6, 6, 6, 6, sticker)).to eq(284)
  end

  context "#roll" do
    it "returns an array of rolled dice values" do
      game = DiceGame.new
      die1 = DiceGame::Die.new
      die2 = DiceGame::Die.new
      die3 = DiceGame::Die.new
      rolls = game.roll(die1, die2, die3)
      expect(rolls.length).to eq(3)
      rolls.each do |roll|
        expect(roll).to be_between(1, 6).inclusive
      end
    end

    it "rolls a die, including one with a sticker" do
      sticker = DiceGame::Sticker::Multiplier.new(value: 2)
      die_with_sticker = DiceGame::Die.new(faces: [1, 2, 3, 4, 5, sticker])
      roll = die_with_sticker.roll
      expect([1, 2, 3, 4, 5, sticker]).to include(roll)
    end
  end
end
