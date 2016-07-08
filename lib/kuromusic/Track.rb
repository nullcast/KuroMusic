require_relative "Object"
require_relative "Key"
require_relative "Track/Measure"

class Track < Object
  def initialize(key, measures = [], channel = 1)
    @key = key
    @measures = measures
    @channel = channel
  end

  def [](index)
    @measures[index]
  end

  def []=(index, obj)
    if obj.class.to_s == "Measure"
      @measures[index] = obj
    else
      self.error_puts("ArgumentTypeError", "undefined method `+'")
    end
  end

  def insert(index, *objs)
    objs.each {|e|
      if e.class.to_s != "Measure"
        self.error_puts("ArgumentTypeError", "undefined method `+'")
      end
    }
    @measures.insert(index, *objs)
  end

  def push(obj)
    if obj.class.to_s == "Measure"
      @measures.push(obj)
    else
      self.error_puts("ArgumentTypeError", "undefined method `+'")
    end
    self
  end

  def unshift(obj)
    if obj.class.to_s == "Measure"
      @measures.unshift(obj)
    else
      self.error_puts("ArgumentTypeError", "undefined method `+'")
    end
    self
  end

  def each()
    @measures.each {|e|
      yield(e)
    }
  end

  def each_with_index()
    @measures.each {|e|
      yield(e)
    }
  end

  def map()
    result = @measures.map {|e|
      yield(e)
    }
    Track.new(result)
  end

  def map!()
    @measures.map! {|e|
      yield(e)
    }
  end

  def length()
    @measure.length
  end

  def +(other)
    tmp = []
    if other.class.to_s == "Track"
      tmp.push(@measures)
      other.each{|e|
        tmp.push(e)
      }
      tmp.flatten!
    else
      self.error_puts("ArgumentTypeError", "undefined method `+'")
    end
    Track.new(@key, tmp)
  end

  def inspect()
    "[
  Track Meta: < key = #{@key}, channel = #{@channel} >
  ----------------------------------------------------------
  " + @measures.each_with_index.map{|m, i|
    "Measure #{i+1}:\n" + m.inspect(@key)
  }.join("\n  ----------------------------------------------------------\n  ") + "
]"
  end
end
