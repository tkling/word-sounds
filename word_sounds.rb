require 'midi'

module WordSounds
  class << self

    def soundify(sentence)
      $output = UniMIDI::Output.gets
      puts ''

      MIDI.using($output) do
        sounds = %w(do re me fa so la ti da)
        octaved_sounds = (1..4).map { |num| sounds.map { |sound| "#{sound}#{num}" } }.flatten

        # break sentence into words
        broken = sentence.split(' ')

        # housekeeping
        min_octave = 1
        $max_octave = 4
        notes_per_octave = 7
        total_octaves = $max_octave - min_octave + 1

        # extra +1 is to account for final high note => #{root note of scale}#{max_octave + 1}
        $total_notes = total_octaves * notes_per_octave + 1

        # for each word, find the word sound
        words_and_sounds = broken.map do |word|
          { :word => word, :sound => WordSounds.find_first(word, sounds, octaved_sounds) }
        end

        scale = (min_octave..$max_octave).map do |num|
          ["C#{num}", "D#{num}", "E#{num}", "F#{num}", "G#{num}", "A#{num}", "B#{num}"]
        end.flatten.push("C#{$max_octave + 1}")

        whoa = octaved_sounds.zip(scale).to_h
        possible_durations = [0.3, 0.7, 0.9, 1.2, 1.5, 1.8, 2.1, 2.4, 2.7, 3.2]
        observed_duration = 0.0

        words_and_sounds.each do |word_sound|
          note = whoa[word_sound[:sound]]
          duration = possible_durations[rand(possible_durations.count - 1)]
          puts "note: #{note}, duration: #{duration}"
          observed_duration += duration
          play(note, duration)
        end

        puts "Hooray! Total duration was #{observed_duration} seconds."
      end
    end

    def find_first(word, sounds, octaved_sounds)
      sounds.each { |s| return s + (rand($max_octave - 1) + 1).to_s if word.downcase.include?(s) }
      octaved_sounds[rand($total_notes - 1)]
    end

  end
end
