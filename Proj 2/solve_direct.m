function [x, err_norm, time] = solve_direct(A,b,N)
tic;
[L, U] = my_lu(A);

y = devide(L,b);
x = devide(U,y);

time = toc;
err_norm = norm(mul(A,x)-b);
end
