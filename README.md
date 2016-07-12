# KuroMusic

KuroMusic is midi controll library written by ruby.

##version
0.1.0

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kuromusic'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kuromusic

## Usage

you should require KuroMusic in your source code to use those method.
```ruby:
require "KuroMusic"
```

###define DELTA TIME

you should define delta time.
delta time is imaginary time as quarter note used in MIDI.
```ruby:
DELTA_TIME = 480
```

###generating melody on yourself
```ruby:
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
```

###generating melody automaticaly
```ruby:
DELTA_TIME = 480
midi = Midi.new(DELTA_TIME, 2)
melo = MelodyGenerater.new(DELTA_TIME, Key::E::NATURAL, Scale::MAJOR).extend(MelodyGenerater::Schenker)
midi.tracks[0] = melo.generate(10, 4)
midi.tracks[1] = melo.generate(10, 2)
```

###changing tempo
```ruby:
can_track = melo.generate(10, 4)
can_track[0].set_meta(Event::Meta::set_tempo(171))
```

###connecting tracks
```ruby:
a_can_track = melo.generate(10, 4)
b_can_track = melo.generate(10, 4)
midi.tracks[0] = a_can_track + b_can_track
```

###write midi file
```ruby:
Midi::IO.write("hoge.mid", midi)
```

##reference
###Note
Note.new(degree, octave, velocity, duration)

duration is based on delta time.

###Chord
Chord.new([Notes])

###Measure
Measure.new([Chords])

###Track
Track.new(key, [Measures])

###Key
- Key::C::NATURAL
- Key::B::SHARP
- Key::C::SHARP
- Key::D::FLAT
- Key::D::NATURAL
- Key::D::SHARP
- Key::E::FLAT
- Key::E::NATURAL
- Key::F::FLAT
- Key::E::SHARP
- Key::F::NATURAL
- Key::C::FLAT
- Key::B::NATURAL
- Key::A::SHARP
- Key::B::FLAT
- Key::A::NATURAL
- Key::A::FLAT
- Key::G::SHARP
- Key::G::NATURAL
- Key::G::FLAT
- Key::F::SHARP

###Scale
- Scale::MAJOR
- Scale::MINOR
- Scale::PENTATONIC
- Scale::WHOLE_TONE
- Scale::OKINAWA
- Scale::INDIAN
- Scale::GYPSY
- Scale::KUMOI

## Contributing

1. Fork it ( https://github.com/[my-github-username]/kuromusic/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
