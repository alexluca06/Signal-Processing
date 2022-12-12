clear; close all;
%% Variables:
N = 64;  % number of samples
f1 = 3000;
f2 = 15000;
f3 = 30000;
fs = 64000;  % sample frequency
tx = 0:1:N-1;

%%  Build the signals:
x1 = sin(2*pi*(f1/fs)*tx);
x2 = sin(2*pi*(f2/fs)*tx);
x3 = sin(2*pi*(f3/fs)*tx);

%% Build the filters
b1 = fir1(N, 0.1, "low");  % low-pass filter
b2 = fir1(N, 0.8, "high");  % high-pass filter
b3 = fir1(N, [0.2 0.4], "bandpass");  % band-pass filter

%% Plot filters:
figure;
freqz(b1, 1);
figure;
freqz(b2, 1);
figure;
freqz(b3, 1);

%% Filtering the signals:
y1 = filter(b1,1,x1);
y2 = filter(b1,1,x2);
y3 = filter(b1,1,x3);

%% Plot filtered signals:

% Low-Pass filtering:
figure;
stem(y1);
hold on;
stem(y2);
hold on;
stem(y3);
legend("x1=3kHz", "x2=15kHz", "x3=30kHz");
title("Applying low-pass filtering");

% High-Pass filtering:
y4 = filter(b2,1,x1);
y5 = filter(b2,1,x2);
y6 = filter(b2,1,x3);
figure;
stem(y4);
hold on;
stem(y5);
hold on;
stem(y6);
legend("x1=3kHz", "x2=15kHz", "x3=30kHz");
title("Applying high-pass filtering");

% Band-Pass filtering:
y7 = filter(b3,1,x1);
y8 = filter(b3,1,x2);
y9 = filter(b3,1,x3);
figure;
stem(y7);
hold on;
stem(y8);
hold on;
stem(y9);
legend("x1=3kHz", "x2=15kHz", "x3=30kHz");
title("Applying band-pass filtering");

%% Plot the frequency response of filters:

[H, freq] = freqz(b3, N, fs);
figure;
plot(freq, abs(H));
xlabel('Frequency (Hz)');
ylabel('Frequency response');
title("Band-Pass Filter");