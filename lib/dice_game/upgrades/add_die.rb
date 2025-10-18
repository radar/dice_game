class DiceGame
  module Upgrades
    class AddDie
      POSSIBLE_DICE = [4] * 1 + [6] * 2 + [8] * 5 + [10] * 5 + [12] * 2 + [20] * 1

      def self.random_die
        DiceGame::Die.build(faces: POSSIBLE_DICE.sample)
      end
    end
  end
end
