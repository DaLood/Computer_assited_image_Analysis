%% Lab3
clear; close all;
I = imread('coins.tif'); % 48 coins

% Puts a threshold, makes it binary 
t = graythresh(I);
BW = im2bw(I,t);

% Get ride of noise --> median filter
BW = medfilt2(BW);   % Median of image, bg=black 
figure; 
imshow(BW); title("Black and white, median filtered")

se = strel('disk',5);
BW = imopen(BW, se);

% Negated distance tranform of binary image
BW = - bwdist(BW, 'chessboard');

% Watershed segmentation
BORDERS = single(watershed(BW));    % Turn single to be able to compare
BW(BORDERS == 0) = 0;
figure; imagesc(BW); title("Watersheded image");


% Setting labels
[Ilabel, n] = bwlabel(BW);
F = regionprops(Ilabel, 'Area');
A = [F.Area];




% Radie
stats = regionprops('table', Ilabel,'Centroid', 'MajorAxisLength', 'MinorAxisLength');
centers = stats.Centroid;
diameters = mean([stats.MajorAxisLength stats.MinorAxisLength], 2);
radii = diameters/2;

hold on 
viscircles(centers,radii);
hold off



figure; hist(A); title("Histogram of areas")



