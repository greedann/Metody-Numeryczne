function [x,time,iterations, err] = solve_Jacobi(A,b,N,max_err_norm)

x = ones(N, 1);
D = diag(diag(A));
M = -D\(tril(A,-1)+triu(A,1));
bm = D\b;
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
