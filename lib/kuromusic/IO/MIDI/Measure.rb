require_relative "Chord"
require_relative "Event"

class Midi
  private
    module Measure
      def to_bin(key)
        @metas.map {|m|
          m.extend(Midi::Event)
          m.to_bin
        }.flatten.concat @chords.map {|c|
          c.extend(Midi::Chord)
          c.to_bin(key)
        }.flatten!
      end
    end
end
