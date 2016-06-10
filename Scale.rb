module Scale extend self
  MAJOR = ["C", "D", "E", "F", "G", "A", "B"]
  MINOR = ["C", "D", "D#", "F", "G", "G#", "B"]
  PENTATONIC = ["C", "D", "E", "G", "A"]
  WHOLE_TONE = ["C", "D", "E", "F#", "G#", "A#"]
  OKINAWA = ["C", "E", "F", "G", "B"]
  INDIAN = ["C", "C#", "E", "F#", "G", "A", "B"]
  GYPSY = ["C", "C#", "E", "F", "G", "G#", "B"]
  KUMOI = ["C", "D", "D#", "G", "A"]

  def note_to_n(note)
    map = {"C"=>0, "C#"=>1, "D"=>2, "D#"=>3, "E"=>4, "F"=>5, "F#"=>6, "G"=>7, "G#"=>8, "A"=>9, "A#"=>10, "B"=>11}
    map[note]
  end

  def number_to_code(number)
    map = {0=>"C", 1=>"C#", 2=>"D", 3=>"D#", 4=>"E", 5=>"F", 6=>"F#", 7=>"G", 8=>"G#", 9=>"A", 10=>"A#", 11=>"B"}
    map[number]
  end
end
