close all;clear all;

I=imread('coins.tif');
imshow(I);




figure
histogram(I);


% level = graythresh(I);
% BW = imbinarize(I,level);
% 
% 
BW = imextendedmax(I,45); 



figure
idist = bwdist(BW,'euclidean');
imshow(idist)


W = watershed(idist);

figure
imshow(W);