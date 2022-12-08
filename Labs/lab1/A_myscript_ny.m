clear all;
close all;
close force all
kyrka = imread('domkyrka.jpg'); % Read the image and save it as kyrka
% image(kyrka)
% figure
kyrka_grey = rgb2gray(kyrka);   % Convert the image to 128 x 128 pixel size,
                                % without changing the aspect ratio of the
                                % image.
% image(kyrka_grey)
% figure

kyrka_crop = imresize(kyrka_grey, [128 128]); % Rezise the image
kyrka_ny = single(kyrka_crop);                % Change datatype to single
image(kyrka_crop)
title('start')
figure

ny = zeros(128,128);   % Create a empty Matrix

newcol = zeros(128,1); % Create empty columns
newrow = zeros(1,132); % Create empty rows

% Create a Matrix that have double zero rows and columns in the start & end
kyrkan = [newcol newcol kyrka_ny(:,1:128) newcol newcol]; 
kyrkan_col_rad = [newrow; newrow; kyrkan(:,1:132); newrow; newrow];
image(kyrkan_col_rad)
title('la på en ram')
figure

%%%%%%%%%%%%%%%%%%%__TEST__%%%%%%%%%%%%%%%%%%
window_size = 5; 
filter_type=fspecial('average', window_size); 
filtered_image = imfilter(kyrka_crop,filter_type, 'replicate'); %%%  I = image
image(filtered_image)
title('imfilter, fusk')
figure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 3:130               % Loop 2 steps in, starting at 3. 
    for j = 3:130           % Loop 2 steps in, starting at 3.
        sum = 0;
        count = 0;
        for f = -2:2        % Getting 5x5 kernal
            for q = -2:2
                if kyrkan_col_rad(i+f, j+q) == 0
                   sum = sum + 0;
                else
                    sum = (sum + int32(kyrkan_col_rad(i+f, j+q))); % adding values
                    count = count + 1; % keeping track of amount values being added
                end
            end
        end
        ny(i-2,j-2) = (sum/count); % appending new average values to new matrix
    end
end

image(ny)                   % Looking at new image
title('egengjord')
figure
sista = ny - kyrka_ny;      % Subtract the original image from your new filtered image.
image(sista)
title('ny minus orginal')
figure

subplot(3,1,1);
image(kyrka_ny)

subplot(3,1,2);
image(ny)

subplot(3,1,3);
image(sista)
