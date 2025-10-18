class DiceGame
  class Sticker
    class Addition < Sticker
      attr_reader :value

      def initialize(value:)
        @value = value
      end

      def inspect
        "+#{value}"
      end

      def to_s
        "+#{value}"
      end

      def apply(score)
        score + value
      end
    end
  end
end
