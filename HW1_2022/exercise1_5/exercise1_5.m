close all;
clear;
clc;

data_file = './data/mnist.mat';

data = load(data_file);

% Read the train data
[train_C1_indices, train_C2_indices,train_C1_images,train_C2_images] = read_data(data.trainX,data.trainY.');

% Read the test data
[test_C1_indices, test_C2_indices,test_C1_images,test_C2_images] = read_data(data.testX,data.testY.');

%%%%%%%%%%%%%%%%%%%%%%%%% Training%%%%%%%%%%%%%%%%%%
%% Compute Aspect Ratio
size1 = size(train_C1_indices,2);
size2 = size(train_C2_indices,2);
size_sum = size(train_C1_indices,2) + size(train_C2_indices,2);

% Compute the aspect ratios of all images and store the value of the i-th image in aRatios(i)
aRatio = zeros(size_sum,1);

rectangle_position = zeros(size_sum,4);

for i = 1 : size1
    [aRatio(i),rectangle_position(i,:)] = computeAspectRatio(squeeze(train_C1_images(i,:,:)));
end
for j = size1 + 1 : size_sum
    [aRatio(j),rectangle_position(j,:)] = computeAspectRatio(squeeze(train_C2_images(j-size1,:,:)));    
end

minAspectRatio = min(aRatio)
maxAspectRatio = max(aRatio)
%%%%%Show rectangle for 2 random images
i1 = randi(size1);
i2 = randi(size2);

rand_image1 = squeeze(train_C1_images(i1,:,:));
rand_image2 = squeeze(train_C2_images(i2,:,:));

[aratio1,rec_pos1] = computeAspectRatio(rand_image1);
[aratio2, rec_pos2] = computeAspectRatio(rand_image2);

figure()
subplot(1,2,1)
imagesc(rand_image1);
hold on;
rectangle('Position', rec_pos1,'EdgeColor','r','LineWidth', 3); 
xlabel(sprintf('Digit %d', 1));
colormap(gray);
hold off;

subplot(1,2,2)
imagesc(rand_image2);
hold on;
rectangle('Position', rec_pos2,'EdgeColor','r','LineWidth', 3); 
xlabel(sprintf('Digit %d', 2));
colormap(gray);
hold off;


%% Bayesian Classifier

% Prior Probabilities


PC1 = size1/(size_sum)
PC2 = size2/size_sum
mu_C1 = mean(aRatio(1:size1));
mu_C2 = mean(aRatio(size1 + 1 : size_sum));
sigma_C1 = std(aRatio(1:size1));
sigma_C2 = std(aRatio(size1 + 1 : size_sum));
   
%%%%%%%%%%%%%%%%%%%%%%%% Testing %%%%%%%%%%

test_size1 = size(test_C1_indices,2);
test_size2 = size(test_C2_indices,2);
test_size_sum = size(test_C1_indices,2) + size(test_C2_indices,2);
count_errors=0;
for i = 1 : test_size1
    [aRatio1,rectangle_position1] = computeAspectRatio(squeeze(test_C1_images(i,:,:)));
    % Likelihoods
    PgivenC1 = normpdf(aRatio1,mu_C1,sigma_C1);
    PgivenC2 = normpdf(aRatio1,mu_C2,sigma_C2);
    % Posterior Probabilities
    PC1givenL = PC1*PgivenC1;
    PC2givenL = PC2*PgivenC2;
    % Classification result
    BayesClass = PC1givenL- PC2givenL;
    % Count misclassified digits
    if BayesClass < 0
     count_errors = count_errors+1;
    end
end 
for i = 1  :test_size2

    [aRatio2,rectangle_position2] = computeAspectRatio(squeeze(test_C2_images(i,:,:)));
    % Likelihoods
    PgivenC1 = normpdf(aRatio2,mu_C1,sigma_C1);
    PgivenC2 = normpdf(aRatio2,mu_C2,sigma_C2);
    % Posterior Probabilities
    PC1givenL = PC1*PgivenC1;
    PC2givenL = PC2*PgivenC2;
    % Classification result
    BayesClass = PC1givenL- PC2givenL;
    % Count misclassified digits
    if BayesClass > 0
     count_errors = count_errors+1;
    end
end 
% Total Classification Error (percentage)
Error = count_errors/test_size_sum