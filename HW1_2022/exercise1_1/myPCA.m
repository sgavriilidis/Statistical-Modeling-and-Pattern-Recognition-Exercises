function [U, S] = myPCA(X)
%PCA Run principal component analysis on the dataset X
%   [U, S, X] = myPCA(X) computes eigenvectors of the covariance matrix of X
%   Returns the eigenvectors U, the eigenvalues (on diagonal) in S
%

% Useful values
[m, n] = size(X);

% You need to return the following variables correctly.
U = zeros(n);
S = zeros(n);

% ====================== YOUR CODE GOES HERE ======================
% Apply PCA by computing the eigenvectors and eigenvalues of the covariance matrix. 
%
% covarience matrix
Covar = (X' * X)./ (size(X,1) -1);
%calculate eigenvalus and eigen vectors 
[eigvectors, eigvalues] = eig (Covar);   % diagonal matrix of eigvalues 
                                    % matrix columns are the eigvectors 
% sort  in descending order
%[eigenvaluesSorted, order] = sort (diag(eigvalues), 'descend')% sort ->diag : vector of eigenvalues
%eigvectors = eigvectors (:, order)

U=eigvectors;
S=eigvalues;

%principal components -> eigvectors(:, 1:M);



% =========================================================================

end
