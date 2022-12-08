%% Lab3
clear; close all;
I = imread('coins.tif'); % 48 coins

% Puts a threshold, makes it binary 
t = graythresh(I);
BW = im2bw(I,t);

% Get rid of noise --> median filter
BW = medfilt2(~BW);   % Median of image, bg=black 
figure; 
imshow(BW); title("Black and white, median filtered")

% Negated distance transform of binary image, find coin centers
% Chessboard gave best result
BW_dist = - bwdist(~BW, 'chessboard');

% Watershed segmentation to find boundaries between overlapping coins
BORDERS = single(watershed(BW_dist));    % Turn single to be able to compare
BW(BORDERS == 0) = 0;

% Closing to smooth coins
se = strel('disk', 5);
BW = imopen(BW, se);
figure; imshow(BW); title("Image after watersheding and segmentation");



% Setting labels on objects
[Ilabel, n] = bwlabel(BW);
F = regionprops(Ilabel, 'Area');
A = [F.Area];




% Regionprops to extract features from labeled objects
stats = regionprops('table', Ilabel,'Centroid', 'MajorAxisLength', 'MinorAxisLength');
centers = stats.Centroid;
diameters = mean([stats.MajorAxisLength stats.MinorAxisLength], 2);
radii = diameters/2;
major = stats.MajorAxisLength/2;

%% If mean radius is used
% hold on 
% viscircles(centers,radii);
% hold off

%% If major axis/2 is used
hold on 
viscircles(centers,major);
hold off

figure; hist(major, 25); title("Histogram of major axis/2")


%% Discussion of errors and limitations
% Limitations from coins (50 öringar, 10 kr) being very similar in sizes
% Border coins. Now solved by using major axises/2 to get the largest
% radius (assuming round objects). Better to use radii than area

%% Counting coins
% Since 10 kr and 50 öringar (the coins with the highest and lowest values)
% are so similar in sizes we have to make assumptions about which bars in
% the histogram belongs to which.
% Can't use it

% Textures, use image template

%% Bacteria
% Assume circular objects
% Radii better for coins (when we know circularity)
% Area better for ellipsoids
% Cases with two or more bacterias?
% Seeded watersheding