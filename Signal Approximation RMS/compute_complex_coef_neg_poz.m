function c=compute_complex_coef_neg_poz(kmax, A)
    k = -kmax:kmax;
    c = zeros(1, length(k));
    for i = 1: length(k)
        if mod(k(i),2) == 1
            c(i) = (2/(1j*pi*k(i)))*A;
        else
            c(i) = 0;  
        end
    end
end