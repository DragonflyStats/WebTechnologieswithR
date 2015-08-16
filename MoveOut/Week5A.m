rng(1234)
rand(5,1)
rng(1234)
rand(5,1)
rng(1234)
A=rand(5,10)
rng(1234)
A=rand(5,20)
rng(1234)
B=rand(5,10)
size(A)
size(B)
sum(A)
size(sum(A))
size(sum(B))
sum(sum(A))
A*B
A*B'
A'*B
C=A'*B
%------------------------------%
% Matrix C
size(C)
size(B'*A)
size((B'*A)')
help sigmoid
sigmoid(C)
C=sigmoid(C);
size(C)
C(1,:)
max(C(1,:))
[u v] = max(C(1,:))
DE = zeroes(20,2)
DE = zeros[20,2]
DE = zeroes[20,2]
help zeroes
help zeros
zeros(20,2)
DE = zeros(20,2)
DE(1,:) = max(C(1,:))
u
v
DE(1,1) = u
DE(1,2) = v
%------------------------------%
% Matrix DE
for  i = 1:20
   [u, v] = max(C(i,:));
   DE(i,1) = u;
   DE(i,2) = v;
end

DE
sum(DE)
C
size(C)
