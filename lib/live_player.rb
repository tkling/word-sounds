require 'midi'
require 'diamond'

puts 'Select the KICK output!'
@kick_output  = UniMIDI::Output.gets

puts 'Select the SYNTH output!'
@synth_output = UniMIDI::Output.gets

@kick_opts = {
  :tx_channel => 3,
  :gate => 30,
  :interval => 2,
  :midi => @kick_output,
  :pattern => Diamond::Pattern["UpDown"],
  :range => 4,
  :rate => 4
}

@synth_opts = {
  :tx_channel => 1,
  :gate => 90,
  :interval => 3,
  :midi => @synth_output,
  :pattern => Diamond::Pattern["Down"],
  :range => 2,
  :rate => 8
}

@kick  = Diamond::Arpeggiator.new(120, @kick_opts)
@synth = Diamond::Arpeggiator.new(120, @synth_opts)
