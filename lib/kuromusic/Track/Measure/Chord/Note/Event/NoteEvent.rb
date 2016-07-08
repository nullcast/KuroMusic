class Event
  module Note extend self
    def on(channel, note, octave, velocity)
      Event.new({
        :type => EventType::NOTE,
        :method => EventType::Note::ON,
        :channel => channel,
        :note => note,
        :octave => octave,
        :velocity => velocity
      })
    end
    def off(channel, note, octave)
      Event.new({
        :type => EventType::NOTE,
        :method => EventType::Note::OFF,
        :channel => channel,
        :note => note,
        :octave => octave
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
