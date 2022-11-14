A = 1;
T = 100;

%% Plot square signal

s = square(A, T);
plot(s)
ylim([-A-1, A + 1]);
title("Square signal")

%% Calculate coefficients + shifted coefficients of signal

kmax = 81;
k = -kmax:kmax;
tau = T/4;  % shift value
coef = compute_complex_coef(kmax, A);
coef_shift = compute_complex_coef_tau(kmax, A, tau);

% Plot the spectrum of complex coefficients

figure;
stem(k, abs(coef));
title("Before shift phase");
ylabel("Magnitude of Component");
xlabel("Frequencu component k");

% Plot the spectrum of complex shifted coefficients

figure;
stem(k, abs(coef_shift));
title("After shift phase with T/4");
ylabel("Magnitude of Component");
xlabel("Frequencu component k");

%% Signal Reconstruction

s_shift = zeros(1, T);
t = 0:1:T;

for i = 1:T
    s_shift(i) = sum(coef_shift.*exp(1j *(2*pi*k*i) / T)); % Fourier Series
end

figure;
plot(s);
hold on;
plot(real(s_shift));
title("Signal Reconstruction after phase shifting");
legend('Before', 'After');
xlim([1, T]);