function [x,time,iterations, err] = solve_Gauss_Seidel(A,b,N,max_err_norm)

x = ones(N, 1);
D = zeros(N, N);
for i = 1:N
    D(i,i) = A(i,i);
end
L = zeros(N, N);
for i = 1:N
    for j = 1:i-1
        L(i,j) = A(i,j);
    end
end

U = zeros(N, N);
for i = 1:N
    for j = i+1:N
        U(i,j) = A(i,j);
    end
end
M = -devide(D+L, U);
bm = devide(D+L, b);

max_iterations = 1000;
iterations = 0;
err = [];

tic
while iterations < max_iterations
    x = mul(M,x) + bm;
    iterations = iterations + 1;
    
    err_norm = norm(mul(A,x)-b);
    err = [err err_norm];
    if (err_norm < max_err_norm)
        break
    end
end
time = toc;
end
