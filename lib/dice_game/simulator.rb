class DiceGame
  class Simulator
    def initialize(dice: 7.times.map { Die.new })
      @dice = dice
    end

    def run(rounds: 1)
      stats = rounds.times.map do
        rolls = @dice.map(&:roll)
        { rolls: rolls, score: DiceGame.new.calculate(*rolls) }
      end

      {
        average_score: stats.sum { |stat| stat[:score] } / rounds.to_f,
        max_score: stats.max_by { |stat| stat[:score] },
        min_score: stats.min_by { |stat| stat[:score] }
      }
    end
  end
end
