function [ Pred_lr ] = lr_test( model, Xtest )
weights=model;
Xtest=full(Xtest);
i=1;
while i<length(Xtest(:,1))+1
    score_1(i)=1/(1+exp(-sum(weights.*Xtest(i,:))));
    score_0(i)=1-1/(1+exp(-sum(weights.*Xtest(i,:))));
    if score_1(i)>score_0(i)
        predict(i)=1;
    else
        predict(i)=0;
    end
i=i+1;    
end
Pred_lr=predict';


end

