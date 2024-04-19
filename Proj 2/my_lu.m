function [L, U] = my_lu(A)

n = size(A, 1);

U = A;
L = zeros(n);
for i=1:n
    L(i,i)=1;
end

for i = 1:n-1
    factor = U(i+1:n, i) / U(i, i);
    L(i+1:n, i) = factor;
    U(i+1:n, :) = U(i+1:n, :) - factor * U(i, :);
end

end