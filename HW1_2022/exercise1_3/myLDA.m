function A = myLDA(Samples, Labels, NewDim)
% Input:    
%   Samples: The Data Samples 
%   Labels: The labels that correspond to the Samples
%   NewDim: The New Dimension of the Feature Vector after applying LDA

    
	[NumSamples NumFeatures] = size(Samples);
    Sw=0;
    Sb=0;
    NumLabels = length(Labels);
    
    if(NumSamples ~= NumLabels) then
        fprintf('\nNumber of Samples are not the same with the Number of Labels.\n\n');
        exit
    end
    Classes = unique(Labels);
    NumClasses = length(Classes) ; %The number of classes
    %Calculate the Global Mean
         m0=(1/NumClasses)*sum(Samples);
    %For each class i
	%Find the necessary statistics
    for i = 1 : NumClasses % for all classes 
        sumOfLabels = 0;
        for j = 1 : NumLabels % and for all labels
            if Labels(j) == Classes(i)
                sumOfLabels = sumOfLabels + 1; 
                found_samples(sumOfLabels,:) = Samples(j,:);
            end
        end 
        %Calculate the Class Prior Probability
        P(i)= sumOfLabels/NumLabels;
        %Calculate the Class Mean 
        mu(i,:) = mean(found_samples);
        %Calculate the Within Class Scatter Matrix
        found_samples_Covar = (found_samples' * found_samples)./ (size(found_samples,1) -1);
        Sw = Sw + P(i) * found_samples_Covar;
          %Calculate the Between Class Scatter Matrix
        Sb = Sb + P(i) * ctranspose(mu(i,:) - m0) * (mu(i,:) - m0);
        
    end
    %Eigen matrix EigMat=inv(Sw)*Sb
    EigMat = inv(Sw)*Sb;
    
    %Perform Eigendecomposition
    [eigvectors, eigvalues] = eig(EigMat);  % diagonal matrix of eigvalues 
                                        	% matrix columns are the eigvectors 
     %sort  in descending order
    [eigenvaluesSorted, order] = sort (diag(eigvalues), 'descend');% sort ->diag : vector of eigenvalues
    eigvectors = eigvectors (:, order);
   
 	
    %Select the NewDim eigenvectors corresponding to the top NewDim
    %eigenvalues (Assuming they are NewDim<=NumClasses-1)
	%% You need to return the following variable correctly.
    
    A=zeros(NumFeatures,NewDim);  % Return the LDA projection vectors
    for d=1:NewDim
        A(:,d)=eigvectors(:,order(d));
    end
    A=A/norm(A);
    
    
