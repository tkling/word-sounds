sounds = {
  :do => 261,
  :re => 294,
  :mi => 330,
  :fa => 349,
  :sol => 392,
  :la => 440,
  :ti => 494,
  :da => 523
}

require 'roscil'

sounds.each do |sound, freq|
  Roscil.sin(freq, 200)
end

require 'midilib/sequence'
require 'midilib/consts'
include MIDI

base = 64
major_intervals = [0, 2, 4, 5, 7, 9, 11, 12]

seq = Sequence.new
track = Track.new(seq)
seq.tracks << track

track.events << Tempo.new(Tempo.bpm_to_mpq(120))
track.events << MetaEvent.new(META_SEQ_NAME, 'Whoa lol')

track = Track.new(seq)
seq.tracks << track

track.name = 'Wow!'
track.instrument = GM_PATCH_NAMES[0]
track.events << Controller.new(0, CC_VOLUME, 127)