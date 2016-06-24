require_relative "Note/Event"

class Note < Object
  attr_reader :note, :octave, :velocity, :dur
  public
    def initialize(note, octave, velocity, dur)
      @note = note
      @octave = octave
      @dur = dur
      @velocity = velocity
    end

    def get_on_event()
      Event::Note::on(@note, @octave, @velocity)
    end

    def get_off_event()
      Event::Note::off(@note, @octave)
    end
end
