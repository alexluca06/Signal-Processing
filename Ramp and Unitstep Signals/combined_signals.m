% Variables:

N = 200;
T = 100;

% Build signals:

s1 = ramp(N);
s2 = [zeros(1,T), s1(1:N-T)];
unit_signal = unitstep(N);
s3 = T * [zeros(1,T), unit_signal(1:N-T)];
sum = s1 - s2 - s3;  % s(i)=r(i)−r(i−T)−T⋅u(i−T)

plot(s1);
hold on;
plot(-s2);
hold on;
plot(-s3);
hold on;
plot(sum, 'black', 'LineWidth',2);
title('Combined signal')
xlabel('N')
legend("r(t)", "r(t-T)", "-u(t-T)", "sum");

