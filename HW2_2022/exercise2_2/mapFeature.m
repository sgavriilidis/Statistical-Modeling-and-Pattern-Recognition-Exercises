function out = mapFeature(X1, X2)
% MAPFEATURE Feature mapping function to polynomial features
%
%   MAPFEATURE(X1, X2) maps the two input features
%   to quadratic features used in the regularization exercise.
%
%   Returns a new feature array with more features, comprising of 
%   X1, X2, X1.^2, X2.^2, X1*X2, X1*X2.^2, etc..
%
%   Inputs X1, X2 must be the same size
%
counter = 1;
degree = 6;
out = ones(length(X1(:,1)), 28);

for i = 0:degree
  for j = 0:i
    out(:, counter) = X2.^(j).*X1.^(i-j);
    counter = counter + 1;
  end
end


end
