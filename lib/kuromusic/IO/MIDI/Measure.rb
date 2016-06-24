require_relative "Chord"

class Midi
  private
    module Measure
      def to_bin()
        @chords.map {|c|
          c.extend(Midi::Chord)
          c.to_bin
        }.flatten!
      end
    end
end
