require_relative "Track/Measure/Chord"

class ChordProgGenerator
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


  public
    def generate(length, x = 3, y = 3)
      code_prog = []
      length.times do |i|
        _ = ChordProgGenerator::LERDAHL_MAP[x][y]
        p _
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
      code_prog
    end
end
