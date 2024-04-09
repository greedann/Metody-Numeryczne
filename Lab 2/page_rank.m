function [numer_indeksu, Edges, I, B, A, b, r] = page_rank()
numer_indeksu = 196691;
L1 = 9;
L2 = 6;
Edges = [1,1,2,2,2,3,3,3,4,4,5,5,6,6,7,8,mod(L2,7)+1 ;
         4,6,3,4,5,5,6,7,5,6,4,6,4,7,6,mod(L1,7)+1,8];
N = 8;

I = speye(N);
B = sparse(Edges(2,:), Edges(1,:), 1);
A = spdiags((1./sum(B))', 0, N, N);
b = ((1-0.85)/N)*ones(N,1);
M = I - 0.85*B*A;
r = M\b;
end