class DiceGame
  class Sticker
    class Max < Sticker
      def inspect
        "MAX"
      end

      def to_s
        "MAX"
      end

      def apply(faces)
        [faces.max] * faces.size
      end
    end
  end
end
