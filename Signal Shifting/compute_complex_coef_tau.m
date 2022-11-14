function c_k_shift=compute_complex_coef_tau(kmax, A, tau)
    k = -kmax:kmax;
    c = zeros(1, length(k));
    c_k_shift = zeros(1, length(k));
    for i = 1: length(k)
        if mod(k(i),2) == 1
            c(i) = (2/(1j*pi*k(i)))*A;
            c_k_shift(i) = c(i) * exp(-1j*2*pi*k(i)*tau/4*tau);
        else
            c(i) = 0;  
            c_k_shift(i) = 0;
        end
    end
end