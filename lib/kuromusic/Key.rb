module Key extend self
  module C extend self
    NATURAL = "C"
    SHARP = "C#"
    FLAT = "Cb"
  end
  module D extend self
    NATURAL = "D"
    SHARP = "D#"
    FLAT = "Db"
  end
  module E extend self
    NATURAL = "E"
    SHARP = "E#"
    FLAT = "Eb"
  end
  module F extend self
    NATURAL = "F"
    SHARP = "F#"
    FLAT = "Fb"
  end
  module G extend self
    NATURAL = "G"
    SHARP = "G#"
    FLAT = "Gb"
  end
  module A extend self
    NATURAL = "A"
    SHARP = "A#"
    FLAT = "Ab"
  end
  module B extend self
    NATURAL = "B"
    SHARP = "B#"
    FLAT = "Bb"
  end

  def key_to_degree(key)
    {
      #positive
      Key::C::NATURAL => 0, Key::B::SHARP => 0,
      Key::C::SHARP => 1, Key::D::FLAT => 1,
      Key::D::NATURAL => 2,
      Key::D::SHARP => 3, Key::E::FLAT => 3,
      Key::E::NATURAL => 4, Key::F::FLAT => 4,
      Key::E::SHARP => 5, Key::F::NATURAL => 5,

      #negative
      Key::C::FLAT => -1, Key::B::NATURAL => -1,
      Key::A::SHARP => -2, Key::B::FLAT => -2,
      Key::A::NATURAL => -3,
      Key::A::FLAT => -4, Key::G::SHARP => -4,
      Key::G::NATURAL => -5,
      Key::G::FLAT => -6, Key::F::SHARP => -6
    }[key]
  end

  def degree_to_key(number)
    {
      0=>"C", 1=>"C#", 2=>"D", 3=>"D#", 4=>"E", 5=>"F", 6=>"F#", 7=>"G", 8=>"G#", 9=>"A", 10=>"A#", 11=>"B"
    }[number % 12]
  end
end
