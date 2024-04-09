function [x, err_norm, time] = solve_direct(A,b,N)
tic;
[L, U] = lu(A);

y = L \ b;
x = U \ y;

err_norm = norm(A*x-b);
time = toc;
end
