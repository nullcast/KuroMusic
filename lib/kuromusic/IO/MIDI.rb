require_relative "MIDI/MidiEvent"
require_relative "MIDI/MidiTrack"

class Midi
  module IO
    public
    def self.load(input_path)
      tempo = 120
      Midi.new(tempo)
    end
    def self.write(output_path, midi)
      File.open(output_path, "wb") do |file|
        track_num = midi.tracks.length
        dtime = midi.dtime
        file.write [0x4d, 0x54, 0x68, 0x64, 0, 0, 0, 6, 0, 1, track_num >> 8, track_num % 256, dtime >> 8, dtime % 256].pack('C*')
        midi.tracks.each {|track|
          track.extend(MidiTrack)
          m = track.to_bin
          track.each {|e|
            #[e.args[:type], e.args[:method], e.args[:note], e.args[:octave], e.args[:dur], e.args[:velocity]]
            p e.args
          }
          #p m
          file.write m.pack('C*')
        }
      end
    end
  end
end
