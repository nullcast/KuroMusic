require_relative "../KuroMusic"

DELTA_TIME = 480
midi = Midi.new(DELTA_TIME, 3)
cpg = ChordProgGenerator.new()
melo = MelodyGenerator.new(DELTA_TIME, Key::C::NATURAL).extend(MelodyGenerator::Chord)

chord_prog = cpg.generate(4)
a_t = melo.generate(2, 5, chord_prog, 100)
a_t[0].set_meta(Event::Meta::set_tempo(120)).set_meta(Event::Meta::program_change(0, 89))
b_t = melo.generate(2, 5, chord_prog, 100)
c_t = melo.generate(2, 5, chord_prog, 100)

a_c_t = melo.generate(8, 4, chord_prog, 100)
a_c_t[0].set_meta(Event::Meta::set_tempo(120))#.set_meta(Event::Meta::program_change(0, 1))
b_c_t = melo.generate(4, 4, chord_prog, 100)
c_c_t = melo.generate(4, 4, chord_prog, 100)

a_b_t = melo.generate(2, 2, chord_prog, 70)
a_b_t[0].set_meta(Event::Meta::set_tempo(120)).set_meta(Event::Meta::program_change(0, 39))
b_b_t  = melo.generate(2, 2, chord_prog, 70)
c_b_t = melo.generate(2, 2, chord_prog, 70)

midi.tracks[0] = a_c_t + b_c_t + c_c_t + a_c_t
midi.tracks[1] = a_t + a_t + a_t + a_t + b_t + b_t + c_t + c_t + a_t + a_t + a_t + a_t
midi.tracks[2] = a_b_t + a_b_t + a_b_t + a_b_t  + b_b_t + b_b_t + c_b_t + c_b_t + a_b_t + a_b_t + a_b_t + a_b_t

#p midi.tracks[0]
Midi::IO.write("../../hoge3.mid", midi)
