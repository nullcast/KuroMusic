require 'pp'
class MelodyGenerator
  module Chord
    private
      XMAX = 6
      YMAX = 6
      LERDAHL_MAP = [
        ['d#', 'F#', 'f#', 'A', 'a', 'C', 'c'],
        ['G#', 'B', 'b', 'D', 'd', 'F', 'f'],
        ['C#', 'E', 'e', 'G', 'g', 'Bb', 'bb'],
        ['F#', 'A', 'a', 'C', 'c', 'Eb', 'eb'],
        ['b', 'D', 'd', 'F', 'f', 'Ab', 'ab'],
        ['e', 'G', 'g', 'Bb', 'bb', 'Db', 'db'],
        ['a', 'C', 'c', 'Eb', 'eb', 'Gb', 'gb']
      ]
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
        @rhythm_with_chord.map {|item|
          _sub = @measure

          chords = item.map do |v|
            ::Chord.new(f.resume(v[:dur], @velocity, v[:chord]))
          end
          Measure.new(chords)
        }
      end

    public
      def chord_prog_generate(num, length, x = 3, y = 3)
        code_prog = []
        num.times do |i|
          _ = ChordProgGenerator::LERDAHL_MAP[x][y]
          chord = nil
          if _[0] == _[0].upcase then
            chord = Chord_::MAJOR
          else
            chord = Chord_::MINOR
          end
          _[0] = _[0].upcase
          key = Key::degree_to_key(Key::key_to_degree(_))
          code_prog.push Chord_::chord_to_degrees(chord, key)
          x = (x + [-1,0,1].sample) % XMAX
          y = (y + [-1,0,1].sample) % YMAX
        end

        counter = 0
        @rhythm_with_chord = []
        length.times do |i|
          @rhythm_with_chord.push @rhythm.map { |dur|
            chord = code_prog[counter]
            counter = (counter + 1) % code_prog.size if (0..10).to_a.sample == 0
            {:chord => chord, :dur => dur}
          }.flatten
        end
      end

      def generate(length, octave, velocity)
        @velocity = velocity
        Track.new(@key, common(length, octave, @note_times[2..3]))
      end
    end
end
