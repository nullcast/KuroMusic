class Event
  module EventType
    NULL = nil
    NOTE = :NOTE
    META = :META
    module Note
      NULL = nil
      ON = :ON
      OFF = :OFF
      REST = :REST
    end
    module Meta
      NULL = nil
      SET_TEMPO = :SET_TEMPO
    end
  end
end
