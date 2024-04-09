N = 966;
max_err_norm = 1e-9;
index = 196766;

% zadanie A

[A] = generate_matrix(N, 5+get_n_index_num(index, 4), -1, -1);
f = get_n_index_num(index, 3);
b = transpose(sin((1:N)*(1+f)));

% zadanie B

[x_Jacobi,time_Jacobi,iterations_Jacobi,err_Jacobi] = solve_Jacobi(A,b,N,max_err_norm);


[x_Gauss_Seidel,time_Gauss_Seidel,iterations_Gauss_Seidel,err_Gauss_Seidel] = solve_Gauss_Seidel(A,b,N,max_err_norm);
plot(err_Gauss_Seidel);
hold on;
plot(err_Jacobi);
legend('Gauss-Seidel','Jacobi');
xlabel('Iterations');
ylabel('Normalised error');
title('Iterative methods error');
yscale('log');
grid on;

hold off;

% zadanie C

[A] = generate_matrix(N, 3, -1, -1);


[x_Jacobi,time_Jacobi,iterations_Jacobi,err_Jacobi] = solve_Jacobi(A,b,N,max_err_norm);


[x_Gauss_Seidel,time_Gauss_Seidel,iterations_Gauss_Seidel,err_Gauss_Seidel] = solve_Gauss_Seidel(A,b,N,max_err_norm);
plot(1:iterations_Gauss_Seidel,err_Gauss_Seidel);
hold on;
plot(1:iterations_Jacobi,err_Jacobi);
legend('Gauss-Seidel','Jacobi');
xlabel('Iterations');
ylabel('Normalised error');
title('Iterative methods error');
yscale('log');
grid on;

hold off;

% zadanie D

[A] = generate_matrix(N, 3, -1, -1);
[x, err, time_direct] = solve_direct(A,b,N);


% zadanie E
sizes = [100,500,1000,2000,3000,4000,5000,6000,7000,8000,9000,10000];

jacobi_times = [];
gauss_seidel_times = [];
direct_times = [];




for N = sizes
    [A] = generate_matrix(N, 5+get_n_index_num(index, 4), -1, -1);
    f = get_n_index_num(index, 3);
    b = transpose(sin((1:N)*(1+f)));
    
    [x_Jacobi,time_Jacobi,iterations_Jacobi,err_Jacobi] = solve_Jacobi(A,b,N,max_err_norm);
    jacobi_times = [jacobi_times,time_Jacobi];
    
    [x_Gauss_Seidel,time_Gauss_Seidel,iterations_Gauss_Seidel,err_Gauss_Seidel] = solve_Gauss_Seidel(A,b,N,max_err_norm);
    gauss_seidel_times = [gauss_seidel_times,time_Gauss_Seidel];
    
    [x,err_norm, time] = solve_direct(A,b,N);
    direct_times = [direct_times,time];
end

figure;
plot(sizes,jacobi_times);
hold on;
plot(sizes,gauss_seidel_times);
plot(sizes,direct_times);
legend('Jacobi','Gauss-Seidel','Direct');
xlabel('size');
ylabel('time');
title('time of solving');
grid on;
hold off;

