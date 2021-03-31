from pydub import AudioSegment
import numpy as np
import matplotlib.pyplot as plt
from scipy.io import wavfile
from tempfile import mktemp
import copy

mp3_audio = AudioSegment.from_file(
    'Gabore_Transform\pia60.mp3', format="mp3")  # read mp3
wname = mktemp('.wav')  # use temporary file
mp3_audio.export(wname, format="wav")  # convert to wav
FS, data = wavfile.read(wname)  # read wav file
Sxx, f, t, img = plt.specgram(data, Fs=FS, NFFT=128, noverlap=127)  # plot

plotted = 10 * np.log10(Sxx)
print(np.min(plotted))
plt.pcolormesh(t, f, plotted)
plt.colorbar()
plt.show()
