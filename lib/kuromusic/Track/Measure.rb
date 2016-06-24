require_relative "Measure/Chord"

class Measure < Object
  def initialize(chords = [], metas = [])
    @chords = chords
    @metas = metas
  end

  def set_meta(meta_event)
    @metas.push(meta_event)
  end

  def inspect()
    "(
    " + @chords.map{|m| m.inspect}.join("\n  ),\n  (\n    ") + "
  )"
  end
end
