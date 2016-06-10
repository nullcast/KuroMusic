require_relative "__GenerateInterface"

class MelodyGenerater
  module Rand
    private
      def fiber(octave, notes, dur, velocity)
        Fiber.new do
          while true do
            note = notes.sample
            velocity = Random.rand(100 .. 1000)
            Fiber.yield [Event::Note::on(note, octave, dur, velocity), Event::Note::off(note, octave)]
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
        Track.new(common(length, octave, @note_times, @scale))
      end
      def cantus(length)
        octave = 4
        Track.new(common(length, octave, @note_times, @scale))
      end
  end
end
