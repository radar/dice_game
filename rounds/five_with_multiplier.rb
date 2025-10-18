require "dice_game"

dice = 5.times.map { DiceGame::Die.new }

simulator = DiceGame::Simulator.new(dice: dice).run(rounds: 100_000)
p simulator
