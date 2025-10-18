class DiceGame
  class Die
    attr_reader :faces
    def initialize(faces: 1..6)
      @faces = faces
    end

    def self.random
      build(faces: [4, 6, 8, 10].sample)
    end

    def self.build(faces: 6, stickers: [])
      all_faces = (1..faces - stickers.size).to_a + stickers
      new(faces: all_faces)
    end

    def inspect
      "#<#{self.class} faces=#{faces}>"
    end

    def to_s
      non_numeric_faces = faces.select { |face| !face.is_a?(Integer) }
      groupings = non_numeric_faces.group_by { |face| [face.class, face.value] }
      "d#{faces.size} #{groupings.map { |(klass, value), faces| "(+#{faces.size} #{faces.join(' ')})" }.join(' ')}".strip
    end

    def roll
      faces.to_a.sample
    end

    def add_sticker(sticker)
      @faces = @faces.to_a.sample(@faces.size - 1) + [sticker]
    end
  end
end
