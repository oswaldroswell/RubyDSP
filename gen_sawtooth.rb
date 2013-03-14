require 'wavefile'

duration    = 2
sample_rate = 48000; bits = 16; hi = 65535; lo = 32768
#sample_rate = 8000;  bits =  8; hi =   255; lo =   128
channels    = 1
frequency   = 440.0
ff          = frequency / sample_rate
samples     = (duration * sample_rate).to_i - 1
w           = WaveFile.new(channels, sample_rate, bits)
filename    = "ramptest.wav"

(0..samples).each do |s|
  w.sample_data[s] = (((s + 128) * ff - ((s + 128) * ff).to_i) * hi).to_i - lo
end

w.save(filename)

# 2013-03-14 Oswald Roswell
#
# This is a very simple sawtooth waveform generator. No volume control.
# I've set it up to be easy to jump between 8 bit/8kHz and 16/48kHz.
# This seems all wrong to me now. Like it should be a function. But it
# is just meant to be a demonstrator and a "sandbox" program.
