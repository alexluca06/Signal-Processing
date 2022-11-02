% Variables:

N = 20;
y = zeros(1,N); % actual speed of car
x = [60, 60, 60 ,60, 60, 60, 60 ,60, 60, 60,... % Autopilot values
    60 ,60, 61, 62, 63 ,65, 65, 65, 65 ,67, 67];
e = zeros(1, N);  % error between actual speed and autopilot speed set
y(1) = 7;  % initial speed

for i=1:N-1

   e(i) = x(i) - y(i); % calculate the error/difference
   y(i+1) = S1(y(i), e(i));  % S2: identity system(in == out)

end

disp(y);
plot(y);
title("Speed evolution")
xlabel("N");
ylabel("Speed (km/h)");