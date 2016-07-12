require_relative "Event"

class Midi
  private
    module Chord
      public
        def to_bin(key, channel)
          predur = 0
          ons = []
          offs = []
          maxdur = 0
          @notes.sort {|a, b|
            a.dur <=> b.dur
          }.each {|n|
            ons += [::Event::Note::rest(0), n.get_on_event(channel, key)]
            maxdur = n.dur if maxdur < n.dur
          }.each {|n|
            currentdur = n.dur - predur
            offs += [::Event::Note::rest(currentdur), n.get_off_event(channel, key)]
            predur = n.dur
          }
          (ons + offs).map {|e|
            e.extend(Midi::Event)
            e.to_bin(channel)
          }.flatten!
        end
    end
end
