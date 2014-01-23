function [ model ] = lr_train( Xtrain, Ytrain )
%lambda=128, alpha=0.000001
Xtrain_full=full(Xtrain);
%Combine Y and X
TrainingSets=cat(2,Ytrain,Xtrain_full);
lambda=1;
alpha=0.0001; N=length(TrainingSets(1,:)); weights=zeros(size(Xtrain(1,:)));
Obj_Val_Old=0; Obj_Val_New=0;flag=1; 

while flag
%shuffle the order
TrainingSets=TrainingSets(randperm(size(TrainingSets,1)),:);
for i=1:length(TrainingSets(:,1))
    p(i)=1/(1+exp(-sum(weights.*TrainingSets(i,2:N))));
    index=find(TrainingSets(i,2:N));
    for j=1:length(index)
        weights(index(j))=weights(index(j))+alpha*((TrainingSets(i,1)-p(i))*TrainingSets(i,index(j)+1)-2*lambda*weights(index(j)));
    end
end

LCL=sum(TrainingSets(:,1)'.*log(p)+(1-TrainingSets(:,1))'.*log(1-p));
Reg=lambda*norm(weights)^2;
Obj_Val_New=LCL-Reg;

if abs(Obj_Val_New-Obj_Val_Old)<0.01
    flag=0;
end

Obj_Val_Old=Obj_Val_New;

end
model=weights;


end

