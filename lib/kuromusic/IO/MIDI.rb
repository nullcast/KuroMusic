require_relative "MIDI/Track"

class Midi
  module IO
    private
    def self.midi_head(bin)
      bin.seek(10)
      track_num = bin.read(2).unpack('C*').reverse.each.with_index.inject(0) do |track_num, (value,index)|
        track_num = track_num + (value << 8 * index)
      end
      dtime = bin.read(2).unpack('C*').reverse.each.with_index.inject(0) do |track_num, (value,index)|
        track_num = track_num + (value << 8 * index)
      end
      return track_num, dtime
    end
    def self.track_head(bin)
      bin.seek(10)
      track_num = bin.read(2).unpack('C*').reverse.each.with_index.inject(0) do |track_num, (value,index)|
        track_num = track_num + (value << 8 * index)
      end
      dtime = bin.read(2).unpack('C*').reverse.each.with_index.inject(0) do |track_num, (value,index)|
        track_num = track_num + (value << 8 * index)
      end
      return track_num, dtime
    end
    public
    def self.read(input_path)
      File.open(input_path, "rb") do |bin|
        track_num, dtime = IO::midi_head(bin)
        puts track_num
        puts dtime
        track_num.times do |i|
          #track_num, dtime = IO::track_head(bin)
        end
        #while rec = bin.read(1)
        #  puts rec
        #end
      end
    end
    def self.write(output_path, midi)
      File.open(output_path, "wb") do |file|
        track_num = midi.tracks.length
        dtime = midi.dtime
        file.write [0x4d, 0x54, 0x68, 0x64, 0, 0, 0, 6, 0, 1, track_num >> 8, track_num % 256, dtime >> 8, dtime % 256].pack('C*')
        midi.tracks.each {|track|
          track.extend(Midi::Track)
          m = track.to_bin
          track.each {|e|
            #[e.args[:type], e.args[:method], e.args[:note], e.args[:octave], e.args[:dur], e.args[:velocity]]
            #p e.args
          }
          #p m
          file.write m.pack('C*')
        }
      end
    end
  end
end
