% Variables:

T = 1;
ft = 1;
f1 = 1*ft;
f2 = 2*ft;

% Signals using for codifications:

s0 = zeros(1, 1001);  % '00'
s1 = sin(2*pi*f1*t);  % '01'
s2 = sin(2*pi*f2*t);  % '10'
s3 = s1 + s2;  % '11'

% Message to sent:

message = randi(3, 1, 10);
display(message);

% Encode the message:

for i=1:10
    t = i-1 : 0.001 : i;
    if(message(i) == 0)
      plot(t,s0);
      hold on;
    end

    if(message(i) == 1)
        plot(t,s1);
        hold on;
    end
    if(message(i) == 2)
       plot(t,s2);
       hold on;
    end
    if(message(i) == 3)
       plot(t,s3);
       hold on;

    end
end

xlim([0 10]);
title("Signal");
ylabel('Amplitude');
xlabel("Time");

