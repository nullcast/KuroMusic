class Midi
  private
    module MidiTrack
      def to_bin()
        track = []
        @events.each {|e|
          e.extend(MidiEvent)
          track.concat e.to_bin
        }
        tl = track.concat([0, 0xff, 0x02, 0]).size
        result = [0x4d, 0x54, 0x72, 0x6b, tl >> 24, tl >> 16, tl >> 8, tl % 256].concat track
      end
    end
end
