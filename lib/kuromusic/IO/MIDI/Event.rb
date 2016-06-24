class Midi
  private
  module Event
    private
      def var_len n
        n < 0x80 ? [n] : [(n>>7|0x80), n % 0x80]
      end

      def note_to_bin()
        case @args[:method]
        when ::Event::EventType::Note::REST
          dur = var_len(@args[:dur])
          return dur
        when ::Event::EventType::Note::OFF
          note_num = NOTE[@args[:note]] + @args[:octave] * OCTAVE_UNIT
          return [0x80, note_num, 0]
        when ::Event::EventType::Note::ON
          note_num = NOTE[@args[:note]] + @args[:octave] * OCTAVE_UNIT
          return [0x90, note_num, @args[:velocity]]
        end
      end

      def meta_to_bin()
        case @args[:method]
        when ::Event::EventType::Meta::SET_TEMPO
          tempo = 60000000 / @args[:tempo]
          return [0, 0xff, 0x51, 0x03, tempo >> 16, tempo >> 8, tempo % 256]
        end
      end

    public
      NOTE = {"C"=>0, "C#"=>1, "D"=>2, "D#"=>3, "E"=>4, "F"=>5, "F#"=>6, "G"=>7, "G#"=>8, "A"=>9, "A#"=>10, "B"=>11}
      OCTAVE_UNIT = 12

      def to_bin()
        p self.args
        if @args[:type] == ::Event::EventType::NOTE
          return note_to_bin
        elsif @args[:type] == ::Event::EventType::META
          return meta_to_bin
        end
      end
  end
end
