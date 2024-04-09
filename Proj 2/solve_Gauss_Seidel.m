function [x,time,iterations, err] = solve_Gauss_Seidel(A,b,N,max_err_norm)

x = ones(N, 1);
D = diag(diag(A));
L = tril(A,-1);
U = triu(A, 1);
M = -(D+L)\U;
bm = (D+L)\b;

max_iterations = 1000;
iterations = 0;
err = [];

tic
while iterations < max_iterations
    x = M*x + bm;
    iterations = iterations + 1;
    
    err_norm = norm(A*x-b);
    err = [err err_norm];
    if (err_norm < max_err_norm)
        break
    end
end
time = toc;
end
