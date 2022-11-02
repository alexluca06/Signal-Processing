% Variables:

f1 = 1600; 
f2 = 1800;
A1 = 1;
A2 = 1;
T = 1/200;
t = 0 : 0.000001 : T;
% T = (1/f1) * k = (1/f2) * l -> k/l = 8/9 -> k/1600 = 8/1600 = 200

%Define sine waves:
signal_1 = A1*sin(2*pi*f1*t);
signal_2 = A2*sin(2*pi*f2*t);

%Plot the signals:

plot(t, signal_1, "blue");
hold
plot(t, signal_2, "red");
title('2 SinWaves');
xlabel('Time');
ylabel('Amplitude');
legend("1600 HZ", "1800 HZ");

% Add the signals:

sum_signal = signal_1 + signal_2;
figure;
plot(t, sum_signal);
title('The sum of 2 Sin Waves');
xlabel('Time');
ylabel('Amplitude');