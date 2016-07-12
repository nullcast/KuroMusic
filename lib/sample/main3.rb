require_relative "../KuroMusic"

DELTA_TIME = 480
midi = Midi.new(DELTA_TIME, 4)
melo = MelodyGenerator.new(DELTA_TIME, Key::F::NATURAL, [DELTA_TIME/4, DELTA_TIME/2, DELTA_TIME, DELTA_TIME*2, DELTA_TIME*4]).extend(MelodyGenerator::Chord)
melo.chord_prog_generate 4, 4
a_t = melo.generate(4, 5, 100)
a_c_t = melo.generate(4, 4, 100)
a_b_t = melo.generate(4, 2, 70)

melo.reset_rhythm
melo.chord_prog_generate 4, 4, 0, 0
b_t = melo.generate(4, 5, 100)
b_c_t = melo.generate(4, 4, 100)
b_b_t  = melo.generate(4, 2, 70)

melo.reset_rhythm
melo.chord_prog_generate 4, 4
c_t = melo.generate(4, 5, 100)
c_c_t = melo.generate(4, 4, 100)
c_b_t = melo.generate(4, 2, 70)

a_t[0].set_meta(Event::Meta::set_tempo(120)).set_meta(Event::Meta::program_change(0, 89))
a_c_t[0].set_meta(Event::Meta::set_tempo(120))#.set_meta(Event::Meta::program_change(0, 1))
a_b_t[0].set_meta(Event::Meta::set_tempo(120)).set_meta(Event::Meta::program_change(0, 39))

midi.tracks[0] = a_c_t + b_c_t + c_c_t + a_c_t
midi.tracks[1] = a_t + b_t + c_t + a_t
midi.tracks[2] = a_b_t + b_b_t + c_b_t + a_b_t

rhythm = RhythmMachine.new(DELTA_TIME/4, [
  [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0],
  [0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0],
  [1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0]
  ].transpose)
drums1 = rhythm.generate(4, 100)
rhythm.reset_sequence([
  [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0],
  [0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0],
  [1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0]
  ].transpose)
drums2 = rhythm.generate(4, 100)
drums1[0].set_meta(Event::Meta::set_tempo(120))
drums2[0].set_meta(Event::Meta::set_tempo(120))

midi.tracks[3] = drums1 + drums2 + drums1 + drums1

Midi::IO.write("../../hoge3.mid", midi)
