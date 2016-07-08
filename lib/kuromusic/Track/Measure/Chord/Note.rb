require_relative "Note/Event"

class Note < Object
  attr_reader :note, :octave, :velocity, :dur
  private
    def get_gdeg_and_goct(key)
      key_n = Key::key_to_degree(key)
      gdeg = (key_n + @degree) % 12
      if gdeg < 0
        goct = @octave - 1
      else
        goct = @octave + (key_n + @degree) / 12
      end
      return gdeg, goct
    end

  public
    def initialize(degree, octave, velocity, dur)
      @degree = degree
      @octave = octave
      @dur = dur
      @velocity = velocity
    end

    def get_on_event(channel, key)
      gdeg, goct = get_gdeg_and_goct(key)
      Event::Note::on(channel, Key::degree_to_key(gdeg), goct, @velocity)
    end

    def get_off_event(channel, key)
      gdeg, goct = get_gdeg_and_goct(key)
      Event::Note::off(channel, Key::degree_to_key(gdeg), goct)
    end

    def inspect(key = nil)
      if key.nil?
        "<:degree=>" + @degree.to_s + ", :octave=>" + @octave.to_s + ", :velocity:=>" + @velocity.to_s + ", :duration=>" + @dur.to_s + ">"
      else
        gdeg, goct = get_gdeg_and_goct(key)
        "<:note=>" + Key::degree_to_key(gdeg) + ", :octave=>" + goct.to_s + ", :velocity:=>" + @velocity.to_s + ", :duration=>" + @dur.to_s + ">"
      end
    end
end
