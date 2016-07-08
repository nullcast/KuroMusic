class Event
  module Meta extend self
    def set_tempo(bpm)
      Event.new({
        :type => EventType::META,
        :method => EventType::Meta::SET_TEMPO,
        :tempo => bpm
      })
    end
    def program_change(channel, number)
      Event.new({
        :type => EventType::META,
        :method => EventType::Meta::PROGRAM_CHANGE,
        :channel => channel,
        :number => number
      })
    end
  end
end
