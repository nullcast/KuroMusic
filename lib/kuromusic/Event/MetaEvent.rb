class Event
  module Meta extend self
    def set_tempo(bpm)
      Event.new({
        :type => EventType::META,
        :method => EventType::Meta::SET_TEMPO,
        :tempo => bpm
      })
    end
  end
end
