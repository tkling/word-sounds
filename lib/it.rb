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
