require_relative "Track"

class RhythmMachine
  private
    def fiber()
      Fiber.new do |dur, velocity, item|
        while true do
          dur, velocity, item = Fiber.yield item.each_with_index.map{|v, i|
            case i
            when 0 then
              octave = 42 / 12
              degree = 42 % 12
            when 1 then
              octave = 38 / 12
              degree = 38 % 12
            when 2 then
              octave = 35 / 12
              degree = 35 % 12
            end
            if(v == 1)
              Note.new(degree, octave, velocity, dur)
            else
              Note.new(degree, octave, 0, dur)
            end
          }
        end
      end
    end

    def common(length)
      f = fiber
      (1..length).map {|i|
        _sub = @measure

        drums = @sequence.map do |item|
          ::Chord.new(f.resume(@dtime, @velocity, item))
        end
        Measure.new(drums)
      }
    end

  public
    def initialize(dtime, sequence = nil)
      @dtime = dtime
      @sequence = sequence
    end

    def generate(length, velocity)
      @velocity = velocity
      Track.new(Key::C::NATURAL, common(length), 9)
    end

    def reset_sequence(sequence)
      @sequence = sequence
    end
end
