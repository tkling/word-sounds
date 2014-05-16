require 'midi'

module WordSounds
  class << self

    def soundify(sentence)
      $output = UniMIDI::Output.gets
      MIDI.using($output) do
        sounds = %w(do re me fa so la ti da)
        octaved_sounds = (1..4).map { |num| sounds.map { |sound| "#{sound}#{num}".to_sym } }.flatten

        # break sentence into words
        broken = sentence.split(' ')

        # for each word, find the word sound
        words_and_sounds = broken.map do |word|
          sound = WordSounds.find_first(word, sounds)
          sound = octaved_sounds[rand(31)] if sound == :unset
          { :word => word, :sound => sound }
        end

        scale = (1..4).map do |num|
          ["C#{num}", "D#{num}", "E#{num}", "F#{num}", "G#{num}", "A#{num}", "B#{num}", "C#{num + 1}"]
        end.flatten

        whoa = octaved_sounds.zip(scale).to_h
        durations = [0.1, 0.3, 0.5, 0.7, 0.9, 1.1, 1.3, 2.0, 2.5, 5.0]

        words_and_sounds.each do |word_sound|
          play(whoa[word_sound[:sound]], durations[rand(9)])
        end
      end
    end

    def find_first(word, sounds)
      value = :unset
      sounds.each do |s|
        if word.downcase.include?(s)
          value = s
          break
        end
      end
      value
    end

  end
end
