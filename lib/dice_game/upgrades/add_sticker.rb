class DiceGame
  module Upgrades
    class AddSticker
      POSSIBLE_STICKERS =
        ["3x"] * 10 +
        ["4x"] * 5 +
        ["5x"] * 3 +
        ["10x"] * 1 +
        ["+50"] * 50 +
        ["+100"] * 20 +
        ["+250"] * 10

      def self.random_sticker
        DiceGame::Sticker.build(POSSIBLE_STICKERS.sample)
      end
    end
  end
end
