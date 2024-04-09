function [num] = get_n_index_num(index, n)
num = floor(mod(index, 10^n) / 10^(n - 1));
end
