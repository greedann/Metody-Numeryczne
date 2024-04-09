function time_delta = estimate_execution_time(N)
% time_delta - różnica pomiędzy estymowanym czasem wykonania algorytmu dla zadanej wartości N a zadanym czasem M
% N - liczba parametrów wejściowych

if (N <=0)
    error('N musi być większe od 0');
end

M = 5000; % [s]
t = (N^(16/11) + N^(pi^2/8)) / 1000;
time_delta = t - M;

end
