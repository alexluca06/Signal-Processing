A = 3;
T = 100;

% Plot square signal

s = square(A, T);
plot(s)
ylim([-A-1, A + 1]);
title("Square signal")

%% Plot the spectrum of complex coefficients

kmax = 100;
k = -kmax:kmax;
coef = compute_complex_coef(kmax, A);
figure;
stem(k, abs(coef));

%% Signal Reconstruction using Fourier Series

s = zeros(1, T);
t = 0:1:T;

for i = 1:T
    s(i) = sum(coef.*exp(1j *(2*pi*k*i) / T));
end

% Plot signal reconstruction:

figure;
plot(real(s));
title("Signal Reconstruction");
xlim([1, T]);
