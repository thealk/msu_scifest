
# SEE YOUR SPEECH!
# Generate a picture of your speech!
# This script will allow you to record and view an image of your waveform and spectrogram.
# It will save a temp PDF and open the PDF to allow you to print.

# INSTRUCTIONS
# Record a sound in Praat and, with the sound selected, run this script

# If you would like to name your picture file, do so here.
# If you leave it blank ("") it will default to the name of the sound file
# 	Default for a new recording is "untitled"

name$ = ""
Record mono Sound...
pause Click continue after you've recorded your sound and Saved to List.


# Parameters
# If figDir is empty, figure will save in same location as Praat script
#soundDir$ = "/Users/thea/Downloads/test/"
figDir$ = ""

xaxis$ = "Time (s)"
yaxis$ = "Frequency (Hz)"

timeMajUnit = 0.5
timeMinUnit = 0.1

width = 10
height_wav = 3
height_sg = 3
height_spectrum = 4

include_spectra = 0
include_wav_sg = 1
pdf = 1


# spectrogram settings
max_freq_sg = 7500

# spectrum settings
spectrum_freq = 10000
min_spectrum_spl = 0
max_spectrum_spl = 40

# Set waveform color
color$ = "Green"

# Specify font type size, color
	Times
	Font size... 15
	'color$'
	Erase all

current_sound$ = selected$ ("Sound")

if name$ == ""
	name$ = current_sound$
endif



# WAV
     # Draw waveform
     # Define size and position of waveform (by specifying grid coordinates)
     Viewport... 0 'width' 0 'height_wav'
		Erase all
     select Sound 'current_sound$'
     Draw... 0 0 0 0 no curve

# SPECTROGRAM
	To Spectrogram... 0.005 'max_freq_sg' 0.002 20 Gaussian
 
     # Define size and position of spectrogram
     Viewport... 0 'width' 'height_wav'-1 'height_sg'+'height_wav'

     # Draw spectrogram
     select Spectrogram 'current_sound$'
	 # Paint... start end freq_start freq_end maxdb autoscaling dynamicRange preemph dynamicCompression garnish
     Paint... 0 0 0 'max_freq_sg' 100 yes 50 6 0 yes
       Text left... yes 'yaxis$'

	Viewport... 0 'width' 0 'height_wav'+'height_sg'


# SPECTRUM
if include_spectra == 1
	start_spectrum = 'height_wav'+'height_sg'-1
	end_spectrum = 'start_spectrum'+'height_spectrum'
	Viewport... 0 'width' 'start_spectrum' 'end_spectrum'
	Grey

	select Sound 'current_sound$'
	To Spectrum... yes
	#To Ltas... 100
	Draw... 0 'spectrum_freq' min_spectrum_spl max_spectrum_spl yes


	Viewport... 0 'width' 0 'end_spectrum'
endif

if 'pdf' = 1
	Save as PDF file... 'figDir$''name$'.pdf
endif

select Sound 'current_sound$'

system open 'figDir$''name$'.pdf

select all
Remove

