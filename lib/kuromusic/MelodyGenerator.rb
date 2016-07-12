require_relative "Track"

require_relative "MelodyGenerator/Random"
require_relative "MelodyGenerator/Schenker"
require_relative "MelodyGenerator/Chord"

class MelodyGenerator
  private
    def rhythm_generate()
      _sub = @measure
      @note_times.reverse.each_with_index.map {|t, i|
        times = @note_times[0..(@note_times.length - 1 - i)]
        _ = []
        while _sub >= t do
          dur = times.sample
          _sub = _sub - dur
          _.push(dur)
        end
        _
      }.flatten
    end
  public
    def initialize(dtime, key, note_times = [dtime/8, dtime/4, dtime/2, dtime, dtime*2, dtime*4], scale = nil)
      @dtime = dtime
      @note_times = note_times
      @key = key
      @scale = scale
      @measure = dtime * 4

      @rhythm = rhythm_generate
    end

    #TODO 与えられたリズムが1小節分か判定したい
    def reset_rhythm(rhythm = nil)
      if(rhythm.nil?)
        @rhythm = rhythm_generate
      else
        @thythm = rhythm
      end
    end
end
