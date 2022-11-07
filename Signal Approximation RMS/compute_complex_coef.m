function c=compute_complex_coef(kmax, A)
    k = 0:kmax;
    c = zeros(1, length(k));
    for i = 1: length(k)
        if mod(k(i),2) == 1
            c(i) = (2/(1j*pi*k(i)))*A;
            %c(i) = (4*(A^2)/(pi^2 * k(i)^2));
        else
            c(i) = 0;  
        end
    end
end