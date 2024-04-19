function A_inverse=inverse(A)
a=length(A);
I=zeros(a);
for i=1:a
    I(i,i)=1;
end
augmat=[A I];

for i=1:a-1
    m=augmat(i,i);
    augmat(i,:)=augmat(i,:)/m;
    for j=i:a-1
        augmat(j+1,:)=augmat(j+1,:) - augmat(i,:)*augmat(j+1,i);
    end
end
augmat(a,:)=augmat(a,:)/augmat(a,a);
for k=2:a
    for g=(k-1):-1:1
        augmat(g,:)=augmat(g,:)-augmat(k,:)*augmat(g,k);
    end
end
A_inverse=augmat(:,a+1:2*a);
end