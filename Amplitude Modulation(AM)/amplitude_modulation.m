%% Variables:

T = 128;  % num of samples
t = 1:1:T;
fc = 20/T;  % carrier frequency
a = 0.05;

%% Define signals:

u = unitstep(t);

s = zeros(1, T);
for t=1:T
    s(t) = exp(-a*t) * u(t);  % exponential decay signal
end

%% Amplitude modulation of the signal:

x = zeros(1, T);
for t=1:T
    x(t) = (1 + s(t)) * cos(2 * pi * fc * t);  % modulated signal
end

%% Plot Original Signal S

figure;
plot(s);
xlabel("Time");
ylabel("Amplitude");
title("Original Signal S");

%% Plot Modulated Signal X

figure;
plot(x);
xlabel("Time");
ylabel("Amplitude");
title("Modulated Signal X");

%% Plot spectrum of s using FFT

h = figure;
fx = zeros(1, T);
findex = T/2*linspace(0,1,T/2);
fx((T/2)+1:end) = findex;
fx(1:T/2) = [-T/2, -findex(end:-1:2)];
fs = fft(s);
stem(fx, abs(fftshift(fs)));
xlabel('Frequency component (k)');
ylabel('Magnitude of component');
title('Fourier coefficients before amplitude modulation');
%print(h, '-dpng', 'coefficients_before_amod.png'); % save as image


%% Plot spectrum of modulated signal x using FFT

figure;
fx = zeros(1, T);
findex = T/2*linspace(0,1,T/2);
fx((T/2)+1:end) = findex;
fx(1:T/2) = [-T/2, -findex(end:-1:2)];
fs = fft(x);
stem(fx, abs(fftshift(fs)));
xlabel('Frequency component (k)');
ylabel('Magnitude of component');
title('Fourier coefficients before amplitude modulation');
