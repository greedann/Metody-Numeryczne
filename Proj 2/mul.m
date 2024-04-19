function C = mul(A, B)

[m1, n1] = size(A);
[m2, n2] = size(B);

if n1 ~= m2
  error('Sizes of matrices are not compatible for multiplication.');
end

C = zeros(m1, n2);

for i = 1:m1
  for j = 1:n2
    for k = 1:n1
      C(i, j) = C(i, j) + A(i, k) * B(k, j);
    end
  end
end
end
