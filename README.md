# KuroMusic
##note
KuroMusic is midi controll library writed by ruby.

##instration
```
$ clone https://github.com/yonama/KuroMusic.git
```

##version
0.6

##how to use
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
