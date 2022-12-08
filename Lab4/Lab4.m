clear all; close all

load cdata
%%
figure(1);plot(cdata(:,1),cdata(:,2),'.')
% Q1. No, because it need to be depended on both x and y

I = imread('handBW.pnm'); % Read the image
figure(2);imshow(I); % Show the image
figure(3);imhist(I); % Show the histogram
t1 = 90;
t2 = 130;

figure(4);mtresh(I,t1,t2);
% Q2. No, because the object and hand are similar in intenisty level.
%%
I2 = imread('hand.pnm'); % Read the image
figure(5);imshow(I2); % Show the image
R = I2(:,:,1); % Separate the three layers, RGB
G = I2(:,:,2);
B = I2(:,:,3);
figure(6);plot3(R(:),G(:),B(:),'.') % 3D scatterplot of the RGB data

figure(7);imhist(R);title('Red'); % Show the histogram
figure(8);imhist(G);title('Green') % Show the histogram
figure(9);imhist(B);title('Blue') % Show the histogram

%%
close all
label_im = imread('hand_training.png'); % Read image with labels
figure(10);imagesc(label_im); % View the training areas

I3(:,:,1) = G; % Create an image with two bands/features
%I3(:,:,2) = B;
I3(:,:,2) = R;
[data,class] = create_training_data(I3,label_im); % Arrange the training data into vectors
figure(11);scatterplot2D(data,class); % View the training feature vectors

Itest = im2testdata(I3); % Reshape the image before classification
C = classify(double(Itest),double(data),double(class)); % Train classifier and classify the data
ImC = class2im(C,size(I3,1),size(I3,2)); % Reshape the classification to an image
figure(12);imagesc(ImC); % View the classification result
%figure(13);imhist(ImC); % View the histeogram result for 1D

% Q3. Assumptions, independence,   OBS SKRIV MER HÄR
%     What makes a classifier linear?
%     Answer: It can divide the data with linear funciton

%%
[data,class] = create_training_data(I,label_im); % Arrange the training data into vectors

Itest_grey = im2testdata(I); % Reshape the image before classification
C_grey = classify(double(Itest_grey),double(data),double(class)); % Train classifier and classify the data
ImC_grey = class2im(C,size(I,1),size(I,2)); % Reshape the classification to an image
%figure(13);imagesc(ImC_grey); % View the classification result

% Q4. Compaired to thresholdning, yes
% But greyscale or single are the same --> doesn't make it any better.
% Classification on par on band or full RGB are definetly the best.

