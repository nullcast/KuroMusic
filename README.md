# KuroMusic

KuroMusic is midi controll library writed by ruby.

##version
0.0.1

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

###generate melody automaticaly
```ruby:
DELTA_TIME = 480
midi = Midi.new(DELTA_TIME, 2)
melo = MelodyGenerater.new(DELTA_TIME, Scale::MAJOR).extend(MelodyGenerater::Rand)
midi.tracks[0] = melo.cantus(10)
midi.tracks[1] = melo.base(10)
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
