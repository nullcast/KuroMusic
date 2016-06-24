require_relative "Chord/Note"

class Chord < Object
  def initialize(notes = [])
    @notes = notes
  end

  def inspect()
    @notes.map{|n| n.inspect}.join(",\n    ")
  end
end
