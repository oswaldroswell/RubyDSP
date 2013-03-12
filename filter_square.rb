#! usr/bin/env ruby

require 'wavefile'

wi        = WaveFile.open("fs_input.wav")
rate      = wi.sample_rate
samples   = wi.sample_data.size - 1
frequency = 55.05
amplitude = 1
bitrate   = wi.sample_rate
#threshold = 32767.0 * 0.5

wo        = WaveFile.new(wi.num_channels, wi.sample_rate, wi.bits_per_sample)


(0..samples).each do |sample|

  last = (2 * (sample - 1) * frequency / bitrate).to_i
  crnt = (2 * sample * frequency / bitrate).to_i
  amplitude = -amplitude if last != crnt
  wo.sample_data[sample] = wi.sample_data[sample]

  if (((wi.sample_data[sample] >= 0) && (amplitude < 0)) \
     || \
     ((wi.sample_data[sample] < 0) && (amplitude >= 0))) #\
     #&& ((wi.sample_data[sample] > threshold) || (wi.sample_data[sample] < -threshold))
    wo.sample_data[sample] = -wi.sample_data[sample]
  end

end


wo.save("fs_output.wav")

# filter_square.rb 2013/03/12 Oswald Roswell
#
# The idea here is open a .wav file and apply a filter to it.
# The filter is a "square frequency filter." IDK. It makes all
# samples positive when the square envelope is positive and all
# samples negative when it's negative. It should give the sound
# quite a squared off buzziness at the filter frequency.
