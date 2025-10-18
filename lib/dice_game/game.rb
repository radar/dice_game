require "rainbow"

class DiceGame
  class Game
    BASE_SCORE = 50
    ROUND_MULTIPLIER = 1.499
    TARGET_SCORES = 1.upto(10).map { |round| (BASE_SCORE * (ROUND_MULTIPLIER*round)).to_i }

    attr_reader :dice, :score, :max_rolls_per_round, :rolls_this_round, :round

    def initialize
      @dice = 6.times.map { DiceGame::Die.random }
      @score = 0
      @max_rolls_per_round = 5
      @rolls_this_round = 0
      @round = 1
      @over = false
      @won = false
    end

    def add_score(*rolls)
      @score += DiceGame.new.calculate(*rolls)
    end

    def next_round!
      @round += 1
      @score = 0
      @rolls_this_round = 0
    end

    def over?
      !!@over
    end

    def won?
      !!@won
    end

    def passed_final_round?
      round >= TARGET_SCORES.size
    end

    def roll!
      rolls = dice.map(&:roll)
      add_score(*rolls)
      @rolls_this_round += 1
      rolls
    end

    def won_round?
      score >= TARGET_SCORES[round - 1]
    end

    def lost_round?
      rolls_this_round >= max_rolls_per_round && !won_round?
    end

    def add_upgrade(upgrade)
      case upgrade
      when :add_die
        new_die = DiceGame::Upgrades::AddDie.random_die
        @dice << new_die
        new_die
      when :add_sticker
        sticker = DiceGame::Upgrades::AddSticker.random_sticker
        @dice.sample.add_sticker(sticker)
        sticker
      when :random
        add_upgrade([:add_die, :add_sticker].sample)
      else
        raise "Unknown upgrade: #{upgrade}"
      end
    end

    def report_status
      puts "Round #{round} / #{TARGET_SCORES.size}"
      puts "Score: #{score}"
      puts "Goal: #{TARGET_SCORES[round - 1]}"
      puts "Rolls: #{rolls_this_round}/#{max_rolls_per_round}"
    end

    def winner_winner!
      @won = true
      @over = true
    end

    def dice_pool
      Rainbow("Dice Pool: #{dice.map(&:to_s).join(', ')}").bg(:yellow).black
    end

    def run
      puts "Welcome to Dice Game!"
      puts "Score at least the target score each round to advance."
      puts Rainbow("You start with a pool of 6 random dice.").bg(:yellow).black
      puts dice_pool


      while round <= TARGET_SCORES.size
        while score < TARGET_SCORES[round - 1] && rolls_this_round <= max_rolls_per_round
          puts "-------------------------"
          report_status
          puts dice_pool
          puts "Press Enter to roll dice..."
          gets

          rolls = roll!
          numeric_rolls = rolls.select { |r| r.is_a?(Numeric) }
          non_numeric_rolls = rolls.reject { |r| r.is_a?(Numeric) }
          roll_stats = "You rolled: #{numeric_rolls.sort.join(', ')}"
          roll_stats += ", " + non_numeric_rolls.map(&:to_s).join(' ') unless non_numeric_rolls.empty?
          puts Rainbow(roll_stats).green
          output = DiceGame.new.calculation_output(*rolls)
          roll_score = DiceGame.new.calculate(*rolls)
          output.each do |line|
            puts Rainbow(line).green
            sleep(0.5)
          end

          puts Rainbow("Roll Score: #{roll_score}").green
          sleep(0.5)
          puts Rainbow("New Score: #{score}!").green
          sleep(1)
        end

        if lost_round?
          puts Rainbow("Final Score: #{score}").red
          puts Rainbow("Sorry, you didn't reach the target score. Game over!").red
          break
        end

        puts Rainbow("Final Score: #{score}").green
        puts Rainbow("Goal: #{TARGET_SCORES[round - 1]}").green
        puts "--------------------------"
        puts Rainbow("Congratulations! You've completed Round #{round}!").bg(:green).black
        if passed_final_round?
          puts Rainbow("You've finished all rounds! You win!").bg(:green).black
          winner_winner!
          break
        end

        puts Rainbow("Dice Pool: #{dice.map(&:to_s).join(', ')}").bg(:yellow).black

        loop do
          puts "Would you like to add a random die, or a random sticker to a dice pool?"
          puts "1. Add a random die (d4 -> d20)"
          puts "2. Add EITHER a single multi sticker to a random die, or add TWO addition stickers"
          puts "3. No thanks, continue to next round"
          choice = gets.chomp
          case choice
          when "1"
            new_die = add_upgrade(:add_die)
            puts Rainbow("You added a #{new_die} to your pool!").green
            break
          when "2"
            new_sticker = add_upgrade(:add_sticker)
            puts Rainbow("You added a #{new_sticker} to one of your dice!").green
            break
          when "3"
            puts Rainbow("Continuing to next round...").green
            break
          else
            puts Rainbow("Invalid choice.").red
          end
          choice = nil
        end

        next_round!
      end
    end
  end
end
