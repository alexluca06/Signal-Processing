A = 1;
T = 100;

% Plot square signal

s = square(A, T);
plot(s)
ylim([-A-1, A + 1]);
ylabel("Amplitude");
xlabel("Time");
title("Square signal")
figure;

% Plot the spectrum of complex coefficients

kmax = 500;
k = 0:kmax;
coef = compute_complex_coef(kmax, A);
stem(k, abs(coef).^2);
%stem(k, abs(coef));
ylabel("Magnitude of Component");
xlabel("Frequency component(k)");
title("Fourier coefficients squared");
figure;


%Compute the RMS(epsilon_N)

N = 500;
find_N = 0;
integr = A^2;  % sum(abs(c_k).^2)
rms = zeros(1, N);

for i = 1:N
    for k = 1:i
        rms(i) = rms(i) + abs(coef(k))^2;
    end
    rms(i) = sqrt(integr - rms(i) * 2);

    % Find minimal N to a good signal reconstruction
    if(rms(i) < 0.05)
        if(find_N == 0)
            N_rms = i;
            find_N = 1;
        end
    end
end

% Plot RMS:

plot(1:1:N, rms);
ylim([0, 1]);
ylabel('RMS(e_N)');
title("Plot RMS of e_N");
figure;

semilogy(1:1:N, rms);
title("Semilogy RMS of e_N");
ylabel('RMS(e_N)');
figure;

loglog(1:1:N, rms);
title("LogLog RMS of e_N");
ylabel('RMS(e_N)');


%%Signal Reconstruction using rms(e_N)

% Calculate the complex coefficients

k = -N_rms:N_rms;
coef1 = compute_complex_coef_neg_poz(N_rms, A);

% Build the reconstruct signal:

s_N = zeros(1, T);
t = 0:1:T;
for i = 1:T
    s_N(i) = sum(coef1.*exp(1j *(2*pi*k*i) / T));
end

% Plot signal reconstruction:

figure;
plot(real(s_N));
title("Signal Reconstruction using N_rms = 164");
xlim([1, T]);