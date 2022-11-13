clear; close all;

I = imread("domkyrka.jpg"); % Load image

I = rgb2gray(I);    % Turn into grey-scale

% Square image
[x, y] = size(I);

freq = zeros(1, 256);

for i = 1:x
    for j = 1:y
        index = I(i, j);
        freq(1, index) = freq(1, index) + 1;
    end
end

nofp = x*y; % number of pixels

freq_prob = freq./nofp; % Frequency probability

c = cumsum(freq_prob);  % Cumulative prob distribution

T = round(c .* 256);   % Mapper

Inew = T(I);
Inew = uint8(Inew);

imhist(I);  % Plot histogram of non-eq image
title('Histogram of non-eq image', FontSize = 16)
figure
imhist(Inew)% Plot histogram of eq-image
title('Histogram of our equalized image', FontSize = 16)
figure
imhist(histeq(I)) % Histogram using histeq
title('Histogram using histeq', FontSize = 16)


figure
imshow(Inew)
title('Our equalized image', FontSize = 16)
figure
imshow(I)
title('Original image', FontSize = 16)
figure
imshow(histeq(I))
title('Histeq image', FontSize = 16)