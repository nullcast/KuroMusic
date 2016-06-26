require_relative "../KuroMusic"

DELTA_TIME = 480
midi = Midi.new(DELTA_TIME, 2)
melo = MelodyGenerater.new(DELTA_TIME, Key::E::NATURAL, Scale::MAJOR).extend(MelodyGenerater::Rand)

a_can_track = melo.generate(5, 4)
a_can_track[0].set_meta(Event::Meta::set_tempo(171))
b_can_track = melo.generate(5, 4)
s_can_track = melo.generate(10, 4)

a_bas_track = melo.generate(5, 2)
a_bas_track[0].set_meta(Event::Meta::set_tempo(171))
b_bas_track = melo.generate(5, 2)
s_bas_track = melo.generate(10, 2)

midi.tracks[0] = a_can_track + b_can_track + s_can_track + a_can_track + b_can_track + s_can_track + a_can_track
midi.tracks[1] = a_bas_track + b_bas_track + s_bas_track + a_bas_track + b_bas_track + s_bas_track + a_bas_track

p midi.tracks[0]
p midi.tracks[1]
Midi::IO.write("../../hoge3.mid", midi)
