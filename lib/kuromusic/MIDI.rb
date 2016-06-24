require_relative "IO/MIDI.rb"
require_relative "Track"

class Midi
  attr_reader :tracks, :dtime

  def initialize()
    @tracks = []
    @dtime = 480
  end

  def initialize(dtime, track_num)
    @tracks = Array.new(track_num, ::Track.new([]))
    @dtime = dtime
  end
end
