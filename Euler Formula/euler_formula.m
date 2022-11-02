% Variables:

t = [0, pi/6, pi/4, pi/3, pi/2]; 

s1 = exp(1j*t);  % <-> cos(t) + j*sin(t)
s2 = exp(-1j*t);  % <-> cos(t) - j*sin(t)

% Calculate the mean of complex exponentials above(s1 & s2):

s3 = (s1 + s2) / 2;  % <-> cos(t) = (exp(j*t) + exp(-j*t)) / 2
x = real(s3);
y = imag(s3);

% Plot:

plot(s1, 'ro'); 
hold on;
plot(s2,  'ro' ,'Color','blue'); 
title("Complex Exponentials");
legend('exp(j*t)', 'exp(-j*t)');

figure;
plot(x);
hold on;
plot (y);
title("The mean of 2 exponentials");
