class MelodyGenerator
  module Schenker
    MIDDLE = [7, 5, 4, 2, 2, 0]
    BACK = [0, 5, 7, 0]

    private
      def fiber(octave, num)
        Fiber.new do |notes, dur, velocity|
          while true do
            notes.each{|n|
              notes, dur, velocity = Fiber.yield (0..(num-1)).to_a.map{|item|
                _n = n + (2 * item)
                octave_ = octave + _n / 12
                degree_ = _n % 12
                Note.new(degree_, octave_, velocity, dur)
              }
            }
          end
        end
      end

      def common(length, octave, _note_times, notes)
        f = fiber(octave, 2)
        (1..length).map {|i|
          chords = []
          note_times = _note_times[0..(_note_times.length - 1)]
          @rhythm.each_with_index do |dur, index|
            #if(index % 2 == 0)
              chords.push ::Chord.new(f.resume(notes, dur, 100))
            #else
            #  chords.push ::Chord.new(f.resume(@scale, dur, 100))
            #end
          end
          Measure.new(chords)
        }
      end

    public
      def generate(length, octave)
        Track.new(@key, common(length, octave, @note_times[2..3], MIDDLE))
      end
    end
end
