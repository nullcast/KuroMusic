class MelodyGenerator
  module Schenker
    MIDDLE = [7, 5, 4, 2, 2, 0]
    BACK = [0, 5, 7, 0]

    private
      def fiber(octave, notes, num)
        Fiber.new do |dur, velocity|
          while true do
            notes.each{|n|
              dur, velocity = Fiber.yield (0..(num-1)).to_a.map{|item|
                _n = n + (2 * item)
                octave = octave + _n / 12
                degree = _n % 12
                Note.new(degree, octave, velocity, dur)
              }
            }
          end
        end
      end

      def common(length, octave, _note_times, notes)
        f = fiber(octave, notes, 2)
        (1..length).map {|i|
          chords = []
          note_times = _note_times[0..(_note_times.length - 1)]
          dur = note_times.sample
          chords.push Chord.new(f.resume(dur, 100))
          _sub = @measure - dur
          note_times.reverse.each_with_index {|t, i|
            times = note_times[0..(note_times.length - 1 - i)]
            while _sub >= t do
              note = @scale.sample
              dur = times.sample
              chords.push Chord.new([Note.new(note, octave, 100, dur)])
              _sub = _sub - dur
            end
          }
          Measure.new(chords)
        }
      end

    public
      def generate(length, octave)
        Track.new(@key, common(length, octave, @note_times[2..3], @scale))
      end
    end
end
