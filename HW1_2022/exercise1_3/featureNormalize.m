function [X_norm, mu, sigma] = featureNormalize(X)
%FEATURENORMALIZE Normalizes the features in X 
%   FEATURENORMALIZE(X) returns a normalized version of X where
%   the mean value of each feature is 0 and the standard deviation
%   is 1. This is often a good preprocessing step to do when
%   working with learning algorithms.


% ============================================================

[Rows,Cols] = size(X);
mu = zeros(1,Cols);             % mean of each column (feature)
sigma = zeros(1,Cols);           % standart deviation of each column
X_norm =  zeros(size(X)); % normalize each column independently

for c = 1 : Cols   
    mu(c) = mean(X(:, c));  
    sigma(c) = std(X(:, c));
    X_norm(:,c) = (X(:,c)-mu(c))/sigma(c);
end

end
