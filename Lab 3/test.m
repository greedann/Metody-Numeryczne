% N = 1000:1000:8000;
% n = length(N);
% vtime_direct = zeros(n,1);
% for i=1:length(N)
%     [~,~,~,time_direct,~,~] = solve_direct(N(i));
%     vtime_direct(i) = time_direct;
% end
% plot_direct(N,vtime_direct);

% N = 10;
% [A,b,M,bm,x,err_norm,time,iterations,index_number] = solve_Jacobi(N);

% N = 1000:1000:8000  ;
% n = length(N);
% vtime_jacobi = ones(1,n); 
% vtime_Gauss_Seidel = ones(1,n);
% viterations_Jacobi = ones(1, n);
% viterations_Gauss_Seidel = ones(1, n);

% for i = 1:n
%     [~,~,~,~,~,~,time_Jacobi,iterations_Jacobi,~] = solve_Jacobi(N(i));
%     [~,~,~,~,~,~,time_Gauss_Seidel,iterations_Gauss_Seidel,~] = solve_Gauss_Seidel(N(i));
%     vtime_jacobi(i) = time_Jacobi;
%     viterations_Jacobi(i) = iterations_Jacobi;
%     vtime_Gauss_Seidel(i) = time_Gauss_Seidel;
%     viterations_Gauss_Seidel(i) = iterations_Gauss_Seidel;
% end

% plot_problem_5(N,vtime_jacobi,vtime_Gauss_Seidel,viterations_Jacobi,viterations_Gauss_Seidel)