function R = ruido_sal_pimienta(M, N, Pa, Pb)
% Chequeo de probabilidades
if (Pa + Pb) > 1
    error('La suma de probabilidades no debe exceder 1')
end

R = ones(M, N) * 0.5;
X = rand(M, N);

R(X <= Pa) = 0;             % pimienta
P = Pa + Pb;
R(X > Pa & X <= P) = 1;     % sal
end