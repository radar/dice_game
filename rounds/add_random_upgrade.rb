require "dice_game"

simulations = 10_000
wins = 0
losses = 1
round_losses = Hash.new(0)

simulations.times do |i|
  puts "Starting simulation #{i} (Wins: #{wins}, Losses: #{losses})"
  game = DiceGame::Game.new

  until game.over?
    if game.passed_final_round?
      game.winner_winner!
      break
    end

    until game.won_round? || game.lost_round?
      game.roll!
    end

    game.report_status
    if game.won_round?
      game.add_upgrade(:random)
      game.next_round!
    elsif game.lost_round?
      round_losses[game.round] += 1

      break
    end
  end

  if game.won?
    wins += 1
  else
    losses += 1
  end
end

puts "Final Results after #{simulations} simulations:"
puts "Wins: #{wins}"
puts "Losses: #{losses}"
puts "Round Losses: #{round_losses.sort.to_h}"
puts "Win Rate: #{(wins.to_f / simulations * 100).round(2)}%"
