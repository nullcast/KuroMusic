require_relative "__GenerateInterface"

class MelodyGenerater
  module Schenker
    MIDDLE = [5, 4, 3, 2, 2, 1]
    BACK = [1, 4, 5, 1]

    private
      def fiber(octave, notes, dur, velocity)
        Fiber.new do
          while true do
            notes.each{|n|
              octave = n / 12
              number = n % 12
              note = Scale::number_to_code(number)
              Fiber.yield [Event::Note::on(note, octave, dur, velocity), Event::Note::off(note, octave)]
            }
          end
        end
      end

      def common(length, octave, _note_times, notes)
        events = []
        length.times {|i|
          note_times = _note_times[0..(_note_times.length - 1)]
          dur = note_times.sample
          _sub = @measure - dur
          f = fiber(octave, notes, note_times.sample, 100)
          events.concat f.resume

          note_times.reverse.each_with_index {|t, i|
            note = @scale.sample
            if _sub > t
              note_times = note_times[0..i]
              events.concat f.resume
              _sub = _sub - t
            end
          }
        }
        events
      end

    public
      def base(length)
        octave = 2
        Track.new(common(length, octave, @note_times[2..5], BACK))
      end

      def cantus(length)
        octave = 4
        Track.new(common(length, octave, @note_times, BACK))
      end
    end
end
