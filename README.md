# KuroMusic

KuroMusic is midi controll library writed by ruby.

##version
0.0.2

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

###generating melody on yourself
```ruby:
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
```

###generating melody automaticaly
```ruby:
DELTA_TIME = 480
midi = Midi.new(DELTA_TIME, 2)
melo = MelodyGenerater.new(DELTA_TIME, Scale::MAJOR).extend(MelodyGenerater::Schenker)
midi.tracks[0] = melo.cantus(10)
midi.tracks[1] = melo.base(10)
```

###changing tempo
```ruby:
can = melo.cantus(10)
can[0].set_meta(Event::Meta::set_tempo(171))
```

###connecting tracks
```ruby:
a_can = melo.cantus(10)
b_can = melo.cantus(10)
midi.tracks[0] = a_can + b_can
```

###connecting tracks
```ruby:
a_can = melo.cantus(10)
b_can = melo.cantus(10)
midi.tracks[0] = a_can + b_can
```

###write midi file
```ruby:
Midi::IO.write("hoge3.mid", midi)
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/kuromusic/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
