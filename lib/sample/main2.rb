require_relative "../KuroMusic"

DELTA_TIME = 480
midi = Midi.new(DELTA_TIME, 1)
chords1 = [
  Chord.new([Note.new(-3, 4, 100, 480),Note.new(0, 4, 100, 480),Note.new(4, 4, 100, 480)]),
  Chord.new([Note.new(-1, 4, 100, 480),Note.new(2, 4, 100, 480),Note.new(5, 4, 100, 480)]),
  Chord.new([Note.new(0, 4, 100, 480),Note.new(4, 4, 100, 480),Note.new(7, 4, 100, 480)]),
  Chord.new([Note.new(2, 4, 100, 480),Note.new(5, 4, 100, 480),Note.new(9, 4, 100, 480)]),
]
chords2 = [
  Chord.new([Note.new(4, 4, 100, 480),Note.new(7, 4, 100, 480),Note.new(11, 4, 100, 480)]),
  Chord.new([Note.new(5, 4, 100, 480),Note.new(9, 4, 100, 480),Note.new(0, 5, 100, 480)]),
  Chord.new([Note.new(7, 4, 100, 480),Note.new(11, 4, 100, 480),Note.new(2, 5, 100, 480)]),
]
midi.tracks[0] = Track.new(
  Key::C::NATURAL,
  [
    Measure.new(chords1),
    Measure.new(chords2)
  ]
)

p midi.tracks[0]

Midi::IO.write("../../hoge3.mid", midi)
