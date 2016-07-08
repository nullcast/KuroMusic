module Chord_ extend self
  MAJOR = "MAJOR"
  MINOR = "MINOR"

  def chord_to_degrees(chord, key)
    criteria = Key::key_to_degree(key)
    case chord
    when Chord_::MAJOR then
      return [criteria, criteria+4, criteria+7]
    when Chord_::MINOR then
      return [criteria, criteria+3, criteria+7]
    end
  end
end
