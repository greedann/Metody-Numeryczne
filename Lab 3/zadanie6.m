% load('filtr_dielektryczny.mat');

N = length(A);
D = diag(diag(A));
L = tril(A,-1);
U = triu(A, 1);

% direct method
tic
r = A\b;
czasGausa = toc;
err_norm = norm(A*r-b);

fprintf('direct method time: %.5f\n', czasGausa);
fprintf('direct method error: %.15f\n', err_norm);

% Jacobi method
r = ones(N, 1);
M = -D\(tril(A,-1)+triu(A,1));
bm = D\b;
max_iterations = 1000;
max_err_norm = 1e-14;
iterations = 0;

tic
while iterations < max_iterations
    r = M*r+bm;
    err_norm = norm(A*r-b);
    if (isnan(err_norm) || isinf(err_norm))
        break
    end
    if (err_norm < max_err_norm)
        break
    end
    iterations = iterations + 1;
end
time = toc;

fprintf('time Jacobi: %.5f\n', time);
fprintf('Jacobi method error: %f\n', err_norm);
fprintf('Jacobi iterations: %d\n', iterations);

% Gauss-Seider method

r = ones(N, 1);
bm = (D+L)\b;

max_iterations = 1000;
max_err_norm = 1e-10;
iterations = 0;

tic
while iterations < max_iterations
    r = -(D+L)\(U*r) + bm;
    err_norm = norm(A*r-b);
    if (isnan(err_norm) || isinf(err_norm))
        break
    end
    if (err_norm < max_err_norm)
        break
    end
    iterations = iterations + 1;
end
time = toc;

fprintf('time Gauss-Seider: %.5f\n', time);
fprintf('Gauss-Seider method error: %f\n', err_norm);
fprintf('Gauss-Seider iterations: %d\n', iterations);