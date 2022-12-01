clear; close all;

N_analog = 5000;
f = 1;
t = linspace(0, 5, N_analog);

%% Create and plot the initial signal:
signal = sin(2*pi*f*t);
figure;
plot(t, signal);
xlabel("Time");
ylabel("Amplitude");
title("Initial signal");

%% Signal sampling:

ts = linspace(0, 5, N_analog/100);  % sampling interval
y = sin(2*pi*f*ts);
figure;
stem(ts, y);
title("Sampled sinewave");

%% Transform digital signal in analog signal
y_analog = zeros(1, N_analog);

for i=1:N_analog
    if(mod(i, 100) == 0)
        y_analog(i) = y(i/100);
    else
        y_analog(i) = 0;
    end
    
end

figure;
stem(t, y_analog);    
title("Continuous Version of Sampled sinewave");

%% Rebuilding the signal: 
N_sinc = N_analog;
f_s = 10;
t_sinc = linspace(-0.2, 0.2, N_sinc/10);
x = f_s*t_sinc;
sincvec = sinc(x);
s_cont_filtered = conv(y_analog, sincvec);

figure;
plot(s_cont_filtered);
title("Reconstructed signal");
