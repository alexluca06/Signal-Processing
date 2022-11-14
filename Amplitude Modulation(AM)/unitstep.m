function y=unitstep(t)
    y = zeros(1, length(t));
    for i=1:length(t)
        if(t(i) > 0)
            y(i) = 1;
        else
            y(i) = 0;
        end
    end
end
