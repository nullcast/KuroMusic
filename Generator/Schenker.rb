class MelodyGenerater
  module Schenker
    MIDDLE = [7, 5, 4, 2, 2, 0]
    BACK = [0, 5, 7, 0]

    private
      def fiber(octave, notes, num)
        Fiber.new do |dur, velocity|
          while true do
            notes.each{|n|
              ons = (0..(num-1)).to_a.map{|item|
                _n = n + (2 * item)
                octave = octave + _n / 12
                number = _n % 12
                note = Scale::number_to_code(number)
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
            }
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
              note = @scale.sample
              dur = times.sample
              events.concat [Event::Note::rest(0), Event::Note::on(note, octave, 100), Event::Note::rest(dur), Event::Note::off(note, octave)]
              _sub = _sub - dur
            end
          }
        }
        events
      end

    public
      def base(length)
        octave = 2
        Track.new(common(length, octave, @note_times[4..5], BACK))
      end

      def cantus(length)
        octave = 4
        Track.new(common(length, octave, @note_times[2..3], MIDDLE))
      end
    end
end
