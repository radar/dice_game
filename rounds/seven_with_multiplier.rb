require "dice_game"

# 5x d6, 1x d8, 1x d6 with 2x sticker
dice = 5.times.map { DiceGame::Die.new }
dice << DiceGame::Die.build(faces: 8)
dice << DiceGame::Die.build(faces: 6, stickers: [DiceGame::Sticker.build("2x")])

simulator = DiceGame::Simulator.new(dice: dice).run(rounds: 100_000)
p simulator
