function [A] = generate_matrix(N, a1,a2,a3)
A = zeros(N, N);
index = 1;
while index <= N
    A(index, index) = a1;
    if index + 1 <= N
        A(index, index + 1) = a2;
        A(index + 1, index) = a2;
    end
    if index + 2 <= N
        A(index, index + 2) = a3;
        A(index + 2, index) = a3;
    end
    index = index + 1;
end
end
