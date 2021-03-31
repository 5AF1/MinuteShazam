import numpy as np
import matplotlib.pyplot as plt

from scipy.io import wavfile
from scipy.signal import butter, filtfilt

from pydub import AudioSegment
from tempfile import mktemp


class Music:
    def __init__(self, filename, NFFT=128, noverlap=0):
        self.fs, self.data = self.read(filename)

        self.to_mono()
        self.low_pass(fc=5000)
        self.downsample(factor=4)
        self.hamming()

        self.spectrum, self.f, self.t, _ = plt.specgram(
            self.data, Fs=self.fs, NFFT=1024, noverlap=1023)
        self.spectrum = 10 * np.log10(self.spectrum)

    def to_mono(self):
        if len((self.data).shape) == 2:
            self.data = (self.data[:, 0]+self.data[:, 1])/2

        return self.data

    def read(self, filename):
        if filename[-1] == '3':
            mp3_audio = AudioSegment.from_file(
                filename, format="mp3")  # read mp3
            filename = mktemp('.wav')
            mp3_audio.export(filename, format="wav")

        fs, data = wavfile.read(filename)

        return fs, data

    def low_pass(self, fc=5000, order=5):
        b, a = butter(order, 2*fc/self.fs)
        self.data = filtfilt(b, a, self.data)

        return self.data

    def downsample(self, factor=2):
        factor = int(np.floor(factor))
        if len(self.data) % factor != 0:
            a = int(np.floor(len(self.data)/factor))
            self.data = self.data[0:a*factor]

        dx = np.zeros(len(self.data)//factor)

        for i in range(len(dx)):
            dx[i] = np.max(self.data[i*factor:(i+1)*factor-1])

        dfs = self.fs/factor

        self.data = dx
        self.fs = dfs

    def hamming(self):
        self.data = self.data * np.hamming(len(self.data))

        return self.data

    def plot_spectrum(self):
        plt.rcParams['figure.figsize'] = [12, 8]
        plt.rcParams.update({'font.size': 18})
        plt.pcolormesh(self.t, self.f, self.spectrum, shading='auto')
        plt.colorbar()
        plt.show()


if __name__ == "__main__":
    a = Music('Python\\pia60.mp3')
    print((a.t[1]-a.t[0]))
    a.plot_spectrum()
