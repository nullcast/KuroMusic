require_relative "Object"

class Track < Object
  def initialize(events = [])
    @events = events
  end

  def [](index)
    @events[index]
  end

  def []=(index, obj)
    if obj.class.to_s == "Event"
      @events[index] = obj
    else
      self.error_puts("ArgumentTypeError", "undefined method `+'")
    end
  end

  def insert(index, *objs)
    objs.each {|e|
      if e.class.to_s != "Event"
        self.error_puts("ArgumentTypeError", "undefined method `+'")
      end
    }
    @events.insert(index, *objs)
  end

  def push(obj)
    if obj.class.to_s == "Event"
      @events.push(obj)
    else
      self.error_puts("ArgumentTypeError", "undefined method `+'")
    end
    self
  end

  def unshift(obj)
    if obj.class.to_s == "Event"
      @events.unshift(obj)
    else
      self.error_puts("ArgumentTypeError", "undefined method `+'")
    end
    self
  end

  def each()
    @events.each {|e|
      yield(e)
    }
  end

  def each_with_index()
    @events.each {|e|
      yield(e)
    }
  end

  def map()
    result = @events.map {|e|
      yield(e)
    }
    Track.new(result)
  end

  def map!()
    @events.map! {|e|
      yield(e)
    }
  end

  def +(other)
    tmp = []
    if other.class.to_s == "Track"
      tmp.push(@events)
      other.each{|e|
        tmp.push(e)
      }
      tmp.flatten!
    else
      self.error_puts("ArgumentTypeError", "undefined method `+'")
    end
    Track.new(tmp)
  end
end
