class DiceGame
  module Upgrades
    class AddSticker
      POSSIBLE_STICKERS =
        ["3x"] * 50 +
        ["4x"] * 100 +
        ["5x"] * 25 +
        ["10x"] * 1 +
        ["+20"] * 20 +
        ["+30"] * 10

      def self.random_sticker
        DiceGame::Sticker.build(POSSIBLE_STICKERS.sample)
      end
    end
  end
end
