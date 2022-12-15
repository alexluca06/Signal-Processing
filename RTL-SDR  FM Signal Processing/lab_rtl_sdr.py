from rtlsdr import RtlSdr # comment this if you don't use a RTL-SDR device
import numpy
import numpy as np
import scipy.signal as signal
import matplotlib.pyplot as plt
#from IPython.display import Audio
from scipy.fftpack import fft
import sounddevice as sd
from scipy.io.wavfile import write

plt.rcParams['figure.dpi'] = 170
plt.rcParams['figure.figsize'] = (8, 4)

# TODO 1: Set here 1 if you use RLT, else 0
use_sdr = 1

F_station = int(98.3e6) # Bucharest FM
Fs = 2280000  # sample rate
N = 8192000  # Samples' Number

if use_sdr == 0:
    x1 = np.load('x1.npy')
else:
    # Initialize RTL-SDR device
    sdr = RtlSdr()

    # Setting device's params
    sdr.sample_rate = Fs
    sdr.center_freq = F_station
    sdr.gain = 'auto'

    # Read the Raw Signal
    x1 = sdr.read_samples(N)
    np.save('x1.npy', x1)

    # Close device's resourses
    sdr.close()
    
# Plot Signal's Spectogram:
plt.figure()
plt.specgram(x1, NFFT=2**10, Fs=Fs)
plt.title("Signal's Spectogram: (X1)")
plt.ylim(-Fs/2, Fs/2)
plt.ticklabel_format(style='plain')
plt.show(block=False)
# plt.savefig('fig1.png')  # to save as a image

# FM Signals are diffused on a bandwidth equals with 200kHz
f_bw = 200000

# Signal filtering:
# https://docs.scipy.org/doc/scipy/reference/generated/scipy.signal.firwin.html#scipy.signal.firwin

# TODO 2: Create a low-pass filter using scipy.signal.firwin:
ntaps = 32  # try more values: 8, 16, 32... 
fcut = f_bw/(Fs/2)
b = signal.firwin(ntaps, fcut, window='hamming') 

# TODO 3: Filter the signal: 
x1f = signal.lfilter(b, 1, x1)

# Plot Signal's Spectogram after filtering:
plt.figure()
plt.specgram(x1f, NFFT=2**10, Fs=Fs)
plt.title("Signal's Spectogram: (X1 after filtering)")
plt.ylim(-Fs/2, Fs/2)
plt.ticklabel_format(style='plain')
plt.show(block=False)

# TODO 4: Subsampling -> result a new sampling frequency
dec_rate = int(Fs/f_bw)  # subsampling factor(the ratio between frequencies)
x2 = signal.decimate(x1f, dec_rate)  # the new signal after subsampling

# The new sampling frequency
Fs_new = Fs / dec_rate

# Plot Signal's Spectogram after subsampling:
plt.figure()
plt.specgram(x2, NFFT=2**10, Fs=Fs_new)
plt.title("Signal's Spectogram: (X1 subsampling)")
plt.ylim(-Fs_new/2, Fs_new/2)
plt.ticklabel_format(style='plain')
plt.show(block=False)

# TODO 5: FM Signal Demodulation:
# 1. Using the subsampling signal(x2) -> build a new signal(a copy of x2) delayed with 1 element (x2_int = x2[1:]);
# 2. Calculate the conjugate of this delayed signal (x2_int): numpy.conj();
# 3. Multiply the subsampling signal (x2) with the conjugate delayed signal(x2_int_conj);
# 4. Calculate the signal phase(the angle): the signal is x2_int_conj;
x2_int = x2[1:]
x2_int_conj = numpy.conj(x2_int)
xx = x2[:-1] * x2_int_conj
x3 = numpy.angle(xx)

# View the FM Signal obtained through power spectral density
# The colored areas correspond to the relevant signal components
# Red -> audio mono
# Orange -> audio stereo
plt.figure()
plt.psd(x3, NFFT=2048, Fs=Fs_new, color='blue')
plt.title("FM Signal's Spectogram, then demodulated")
plt.axvspan(0,             15000,         color='red',    alpha=0.2)
plt.axvspan(19000-500,     19000+500,     color='green',  alpha=0.2)
plt.axvspan(19000*2-15000, 19000*2+15000, color='orange', alpha=0.2)
plt.axvspan(19000*3-1500,  19000*3+1500,  color='blue',   alpha=0.2)
plt.show(block=False)
# plt.savefig('fig4.png')

# TODO 6: Calculate and plot the FFT of the demodulated signal:
# 1. Calculate FFT from x3 using fft function from scipy.fftpack;
# 2. Plot the absolute value of the spectrum (np.abs) between 0 and fs/2;
# Note: You can use np.linspace to create an array of frequencies between 0 and fs, useful at plot;
yf = fft(x3)
nf = len(yf)
xf = np.linspace(0, Fs_new, nf)
plt.figure()
plt.plot(xf[0:nf], 2.0/nf * np.abs(yf[0:nf]))
plt.title('The FFT of the demodulated signal')
plt.grid()
plt.grid()
plt.show(block=True)
# plt.savefig('fig5.png')

# TODO 7: Extraction of the audio signal (mono) by filtering and subsampling:
# 1. Filter the previous signal (x3) to retain only the components between 0 and 15 kHz (corresponding to the mono signal);
# 2. Calculate and plot the FFT for the filtered signal and compare it to the FFT of the previous (unfiltered) signal
# 3. Subsamplig the signal so that you have the final sampling frequency f_audio = 44100 Hz to be able to listen to it
ntaps2 = 32
fmaxa = 15000
fcut2 = fmaxa/(Fs/2) # calculate the cutoff frequency required to stop only the signals between 0 and 15 kHz (also in relation to fs/2)
b2 = signal.firwin(ntaps2, fcut2, window='hamming')
x3f = signal.lfilter(b2, 1, x3)

yff = fft(x3f)
nff = len(yff)
nff2 = int(nff/2)
xff = np.linspace(0, Fs_new, nff)
plt.figure()
plt.plot(xff[0:nff2], 2.0/nff * np.abs(yff[0:nff2]))
plt.title('The FFT of the demodulated signal after filtering on mono channel')
plt.grid()
plt.show(block=True)
# plt.savefig('fig6.png')

f_audio = 44100
dec_audio = int(Fs_new/f_audio) # calculate the subsamplig factor to make subsampling from Fs_new at f_audio
Fs_audio = Fs_new / dec_audio
xa = signal.decimate(x3f, dec_audio)

input("Press Enter to play audio from signal...")

# TODO 8: Playing the signal and saving it as wav
xs = np.int16(xa/np.max(np.abs(xa)) * 32767)
sd.play(xs, f_audio) 
write('x1.wav', f_audio, xs)

print("It's finish!\n")
input("Press Enter to continue...")
