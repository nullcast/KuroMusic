require_relative "../KuroMusic"

DELTA_TIME = 480
midi = Midi.new(DELTA_TIME, 1)
chords1 = [
  Chord.new([Note.new("A", 4, 100, 480),Note.new("C", 4, 100, 480),Note.new("E", 4, 100, 480)]),
  Chord.new([Note.new("B", 4, 100, 480),Note.new("D", 4, 100, 480),Note.new("F", 4, 100, 480)]),
  Chord.new([Note.new("C", 4, 100, 480),Note.new("E", 4, 100, 480),Note.new("G", 4, 100, 480)]),
  Chord.new([Note.new("D", 4, 100, 480),Note.new("F", 4, 100, 480),Note.new("A", 4, 100, 480)]),
]
chords2 = [
  Chord.new([Note.new("E", 4, 100, 480),Note.new("G", 4, 100, 480),Note.new("B", 4, 100, 480)]),
  Chord.new([Note.new("F", 4, 100, 480),Note.new("A", 4, 100, 480),Note.new("C", 4, 100, 480)]),
  Chord.new([Note.new("G", 4, 100, 480),Note.new("B", 4, 100, 480),Note.new("D", 4, 100, 480)]),
]
midi.tracks[0] = Track.new(
  [
    Measure.new(chords1),
    Measure.new(chords2)
  ]
)

Midi::IO.write("../../hoge3.mid", midi)
