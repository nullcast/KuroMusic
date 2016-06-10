class Event
  module Note extend self
    def on(note, octave, dur, velocity)
      Event.new({
        :type => EventType::NOTE,
        :method => EventType::Note::ON,
        :note => note,
        :octave => octave,
        :dur => dur,
        :velocity => velocity
      })
    end
    def off(note, octave)
      Event.new({
        :type => EventType::NOTE,
        :method => EventType::Note::OFF,
        :note => note,
        :octave => octave,
        :dur => 0
      })
    end
    def rest(dur)
      Event.new({
        :type => EventType::NOTE,
        :method => EventType::Note::REST,
        :dur => dur
      })
    end
  end
end
