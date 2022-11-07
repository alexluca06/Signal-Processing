% A simple square signal

function s=square(A, T)
    s = zeros(1, T);
    for t=1:T
        if(t < T/2)
            s(t) = A;
        elseif(t>T/2 && t < T)
            s(t) = -A;
        end
    end
end