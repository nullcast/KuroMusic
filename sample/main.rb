require_relative "../KuroMusic"

DELTA_TIME = 480
midi = Midi.new(DELTA_TIME, 2)
melo = MelodyGenerater.new(DELTA_TIME, Scale::MAJOR).extend(MelodyGenerater::Rand)
midi.tracks[0] = melo.cantus(10)
midi.tracks[1] = melo.base(10)
Midi::IO.write("hoge3.mid", midi)
