import numpy as np
import os
import sounddevice as sd
from pydub import AudioSegment
from tempfile import mktemp
import matplotlib.pyplot as plt

from scipy.io import wavfile

from scipy import signal


plt.rcParams['figure.figsize'] = [12, 8]
plt.rcParams.update({'font.size': 18})


# NFFT = Total space a single fft takes
# noverlap = overlap between 2 fft


def gablore(filename, NFFT=128, noverlap=64, play=False):
    if filename[-1] == '3':
        mp3_audio = AudioSegment.from_file(filename, format="mp3")  # read mp3
        filename = mktemp('.wav')
        mp3_audio.export(filename, format="wav")

    fs, data = wavfile.read(filename)
    print(len((data).shape))
    if len((data).shape) == 2:
        data = (data[:, 0]+data[:, 1])/2
    if play:
        sd.play(data, fs)

    Sxx, f, t, img = plt.specgram(data, Fs=fs, NFFT=128, noverlap=0)
    plotted = 10 * np.log10(Sxx)
    print(fs)
    return t, f, plotted


filename = 'Gabore_Transform\\pia60.mp3'
# Extract data and sampling rate from file

t, f, plotted = gablore(filename)
print(len(t))

plt.pcolormesh(t, f, plotted, shading='auto')
plt.colorbar()
plt.show()
