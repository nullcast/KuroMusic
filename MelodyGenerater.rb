require_relative "Event"
require_relative "Track"

require_relative "Generator/Random"
require_relative "Generator/Schenker"

class MelodyGenerater
  def initialize(dtime, scale, key = nil)
    @dtime = dtime
    @note_times = [dtime/8, dtime/4, dtime/2, dtime, dtime*2, dtime*4]
    @scale = scale
    @key = key
    @measure = dtime * 4
  end
end
