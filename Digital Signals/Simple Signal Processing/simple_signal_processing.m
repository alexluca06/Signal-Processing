clear; close all;

N = 5;  % number of frequencies
t = linspace(0, 1 , 128);
freq = [1, 2, 10, 20, 100];
y = zeros(1, 128);
x = zeros(1, 128);

% Create 5 sinusoids with multiple frequencies:
for k=1:N
    x = sin(2*pi*freq(k)*t) + 0.1*rand(size(t));  % add noise to signal

    y(1) = 0;
    y(2) = 0;
    y(3) = 0;
    y(4) = 0;
    
    % Create the output sequences:
    for i=5:128
         y(i) = (x(i-4) + x(i-3) + x(i-2) + x(i-1)+ x(i))/5;
    end
    
    % Plot all the sequences of input/output:
    figure;
    plot(x)
    hold on;
    plot(y);
    legend("Input", "Output");
end

