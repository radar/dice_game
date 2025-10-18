class DiceGame
  class Sticker
    class Multiplier < Sticker
      attr_reader :value

      def initialize(value:)
        @value = value
      end

      def inspect
        "x#{value}"
      end

      def to_s
        "x#{value}"
      end

      def apply(score)
        score * value
      end
    end
  end
end
