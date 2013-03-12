#! usr/bin/env ruby

require 'wavefile'

duration  = 48000 
frequency = 440
volume    = 0.95
filename  = "squarewave.wav"

w = WaveFile.new(1, 48000, 16)
amplitude = 32767

(0..duration).each do

  |sample|
  last = (2 * (sample - 1) * frequency / 48000).to_i
  crnt = (2 * sample * frequency / 48000).to_i
  if ( last != crnt )
    amplitude = -amplitude
  end
  w.sample_data[sample] = amplitude * volume

end

w.save(filename)

# gen_square01.rb 2013/03/11 Oswald Roswell
#
# This program requires the wavefile gem by jstrait: github.com/jstrait/wavefile
# One could change the duration, frequency, volume and filename to get different
# results. I know, it's almost useless. I know, it's done "all wrong." PLEASE
# correct me! There's got to be a better way! But for now, wasting millions of
# CPU cycles creating 'last' and 'crnt' variables and then comparing them seems
# as good as anything. I think this would be better in some ways:
#
# a = -a if ((2*(s-1)*f/r).to_i) != ((2*s*f/r).to_i)
#
# a=amplitude, s=sample, f=frequency, r=bitrate
