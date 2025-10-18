require "dice_game"

dice = 5.times.map { DiceGame::Die.new }
dice << DiceGame::Die.build(faces: 6, stickers: [DiceGame::Sticker.build("2x")])

simulator = DiceGame::Simulator.new(dice: dice).run(rounds: 100_000)
p simulator
