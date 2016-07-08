require_relative "Track"

require_relative "MelodyGenerator/Random"
require_relative "MelodyGenerator/Schenker"
require_relative "MelodyGenerator/Chord"

class MelodyGenerator
  def initialize(dtime, key, scale = nil)
    @dtime = dtime
    @note_times = [dtime/8, dtime/4, dtime/2, dtime, dtime*2, dtime*4]
    @key = key
    @scale = scale
    @measure = dtime * 4
  end
end
