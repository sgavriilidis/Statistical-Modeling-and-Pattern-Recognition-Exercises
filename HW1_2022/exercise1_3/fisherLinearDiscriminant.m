function v = fisherLinearDiscriminant(X1, X2)

    m1 = size(X1, 1);
    m2 = size(X2, 1);

    mu1(:,1)= mean(X1);% mean value of X1
    mu2(:,1)= mean(X2); % mean value of X2

    S1 =  (X1' * X1)./ (size(X1,1) -1); % scatter matrix/covariance matrix of X1
    S2 =  (X2' * X2)./ (size(X2,1) -1); % scatter matrix/covariance matrix of X2

    Sw = (S1+S2)/2; % Within class scatter matrix S_w
    
    v = inv(Sw)*(mu1-mu2); % optimal direction for maximum class separation /projection

    v = v/norm(v);% return a vector of unit norm

    
    