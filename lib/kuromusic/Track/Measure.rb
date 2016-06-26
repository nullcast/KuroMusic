require_relative "Measure/Chord"

class Measure < Object
  def initialize(chords = [], metas = [])
    @chords = chords
    @metas = metas
  end

  def set_meta(meta_event)
    if meta_event.class.to_s != "Event"
      self.error_puts("ArgumentTypeError", "undefined method `+'")
    elsif meta_event.args[:type] != Event::EventType::META
      self.error_puts("EventTypeError", "undefined method `+'")
    end
    @metas.push(meta_event)
    self
  end

  def inspect(key = nil)
  "  Measure Meta:
" + @metas.map{|m| "  " + m.inspect + "\n"}.join() + "
  (
    " + @chords.map{|m| m.inspect(key)}.join("\n  ),\n  (\n    ") + "
  )"
  end
end
