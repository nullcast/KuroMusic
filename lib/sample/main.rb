require_relative "../KuroMusic"

DELTA_TIME = 480
midi = Midi.new(DELTA_TIME, 2)
melo = MelodyGenerater.new(DELTA_TIME, Scale::MAJOR).extend(MelodyGenerater::Schenker)

a_can = melo.cantus(5)
a_can[0].set_meta(Event::Meta::set_tempo(171))
b_can = melo.cantus(5)
s_can = melo.cantus(10)

a_bas = melo.base(5)
a_bas[0].set_meta(Event::Meta::set_tempo(171))
b_bas = melo.base(5)
s_bas = melo.base(10)

midi.tracks[0] = a_can + b_can + s_can + a_can + b_can + s_can + a_can
midi.tracks[1] = a_bas + b_bas + s_bas + a_bas + b_bas + s_bas + a_bas
Midi::IO.write("../../hoge3.mid", midi)
