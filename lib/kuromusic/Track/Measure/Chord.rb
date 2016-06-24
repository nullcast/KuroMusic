require_relative "Chord/Note"

class Chord < Object
  def initialize(notes = [])
    @notes = notes
  end
end
