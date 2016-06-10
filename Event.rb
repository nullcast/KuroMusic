require_relative "Event/EventType"
require_relative "Event/NoteEvent"
require_relative "Event/MetaEvent"

class Event
  attr_reader :args
  private
    def initialize(args)
      @args = args
    end
end
