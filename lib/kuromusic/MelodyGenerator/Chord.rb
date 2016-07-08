class MelodyGenerator
  module Chord
    private
      def fiber(_octave)
        Fiber.new do |dur, velocity, chord|
          while true do
            dur, velocity, chord = Fiber.yield (0..(((1..chord.size).to_a).sample-1)).to_a.map{|item|
              octave = _octave + chord[item] / 12
              degree = chord[item] % 12
              Note.new(degree, octave, velocity, dur)
            }
          end
        end
      end

      def common(length, octave, _note_times)
        f = fiber(octave)
        (1..length).map {|i|
          chords = []
          _sub = @measure

          _note_times.reverse.each_with_index {|t, i|
            times = _note_times[0..(_note_times.length - 1 - i)]
            while _sub >= t do
              dur = times.sample
              chord = @chords[@counter]
              chords.push ::Chord.new(f.resume(dur, @velocity, chord))
              @counter = (@counter + 1) % @chords.size if (1..3).to_a.sample % 3 == 0
              _sub = _sub - dur
            end
          }
          Measure.new(chords)
        }
      end

    public
      def generate(length, octave, chords, velocity)
        @chords = chords
        @counter = 0
        @velocity = velocity
        Track.new(@key, common(length, octave, @note_times[2..3]))
      end
    end
end
