class DiceGame
  module Upgrades
    class AddSticker
      POSSIBLE_STICKERS =
        # ["2x"] * 5 +
        ["3x"] * 50 +
        ["4x"] * 100 +
        ["5x"] * 25 +
        ["10x"] * 1

      def self.random_sticker
        DiceGame::Sticker.build(POSSIBLE_STICKERS.sample)
      end
    end
  end
end
