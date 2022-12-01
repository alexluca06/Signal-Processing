clear; close all;

N = 64;
fc = 3000;
fs = 8000;
Ts = 1/fs;
t = 0:Ts:100*Ts;

signal = cos(2*pi*fc*t);  % create the signal

% Plot the signal:
figure;
plot(signal);
xlabel("Time");
ylabel("Amplitude");
title("Initial signal");

% Plot the FFT for the signal:
figure;
fx = zeros(1, N);
fidx = (fs/N) * linspace(0,N-1,N);
spectrum = fft(signal, N);
stem(fidx, abs(spectrum));
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Spectrum of signal');

figure;
fidx = (fs/N)*linspace(-N/2, N/2-1, N);
stem(fidx, abs(fftshift(spectrum)));
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Zero-centred frequency spectrum of signal');