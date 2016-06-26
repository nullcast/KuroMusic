require_relative "Chord/Note"

class Chord < Object
  def initialize(notes = [])
    @notes = notes
  end

  def inspect(key = nil)
    @notes.map{|n| n.inspect(key)}.join(",\n    ")
  end
end
