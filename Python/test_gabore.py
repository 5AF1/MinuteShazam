import numpy as np
import os
import sounddevice as sd
import matplotlib.pyplot as plt
from scipy.io import wavfile

from scipy import signal

plt.rcParams['figure.figsize'] = [12, 8]
plt.rcParams.update({'font.size': 18})

"""dt = .001
t = np.arange(0, 2, dt)
f0 = 50
f1 = 250
t1 = 2
x = np.cos(2*np.pi*t*(f0+(f1-f0)*np.power(t, 2)/(3*t1**2)))

fs = 1/dt"""

filename = 'Gabore_Transform\clip.wav'
# Extract data and sampling rate from file
fs, data = wavfile.read(filename)
sd.play(data, fs)
# status = sd.wait()  # Wait until file is done playing

# , NFFT=128, noverlap=120, cmap='jet_r')
Sxx, f, t, img = plt.specgram(
    data, Fs=fs, NFFT=128, noverlap=64)
extent = [t.min(), t.max(), f.min(), f.max()]
plotted = 10 * np.log10(Sxx)
plt.pcolormesh(t, f, plotted, cmap='magma')
"""plt.imshow(Sxx, extent=extent, origin='lower',
           aspect='auto', norm=LogNorm(), cmap='PRGn')"""
plt.colorbar()
plt.show()

"""f, t, Sxx = signal.spectrogram(x, fs, noverlap=250, nfft=256)
plt.pcolormesh(t, f, 10*np.log10(Sxx), cmap='jet_r')
plt.ylabel('Frequency [Hz]')
plt.xlabel('Time [sec]')
plt.colorbar()
plt.show()"""
