class Track
  attr_accessor :events
  def initialize(events = [])
    @events = events
  end

  def +(other)
    result = []
    tmp = []
    tmp.push(self.events).push(other.events)
    tmp.flatten!
    result.events = tmp
    result
  end
end
