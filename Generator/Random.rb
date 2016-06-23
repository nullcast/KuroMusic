class MelodyGenerater
  module Rand
    private
      def fiber(octave, notes, num)
        Fiber.new do |dur, velocity|
          while true do
            ons = (0..(num-1)).to_a.map{|item|
              note = notes.sample
              [Event::Note::rest(0), Event::Note::on(note, octave, velocity)]
            }
            offs = ons.each_with_index.map{|item, i|
              if i == 0
                [Event::Note::rest(dur), Event::Note::off(item[1].args[:note], octave)]
              else
                [Event::Note::rest(0), Event::Note::off(item[1].args[:note], octave)]
              end
            }
            dur, velocity = Fiber.yield [ons, offs].flatten
          end
        end
      end

      def common(length, octave, _note_times, notes)
        events = []
        f = fiber(octave, notes, 2)
        length.times {|i|
          note_times = _note_times[0..(_note_times.length - 1)]
          dur = note_times.sample
          events.concat f.resume(dur, 100)
          _sub = @measure - dur
          note_times.reverse.each_with_index {|t, i|
            times = note_times[0..(note_times.length - 1 - i)]
            while _sub >= t do
              dur = times.sample
              events.concat f.resume(dur, 100)
              _sub = _sub - dur
            end
          }
        }
        events
      end

    public
      def base(length)
        octave = 2
        Track.new(common(length, octave, @note_times[4..5], @scale))
      end
      def cantus(length)
        octave = 4
        Track.new(common(length, octave, @note_times[1..3], @scale))
      end
  end
end
