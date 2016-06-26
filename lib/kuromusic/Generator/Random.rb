class MelodyGenerater
  module Rand
    private
      def fiber(octave, notes, num)
        Fiber.new do |dur, velocity|
          while true do
            dur, velocity = Fiber.yield (0..(num-1)).to_a.map{|item|
              note = notes.sample
              Note.new(note, octave, velocity, dur)
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
              dur = times.sample
              chords.push Chord.new(f.resume(dur, 100))
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
