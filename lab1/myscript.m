clear; close all


kyrka = imread('domkyrka.jpg'); % Read the image and save it as kyrka
% image(kyrka)
% figure
kyrka_grey = rgb2gray(kyrka);   % Convert the image to 128 x 128 pixel size,
                                % without changing the aspect ratio of the
                                % image.
% image(kyrka_grey)
% figure

kyrka_crop = imresize(kyrka_grey, [128 128]); % Rezise the image
bild = single(kyrka_crop);                % Change datatype to single


%bild = imread('domkyrka.png'); % read the image
%bild = rgb2gray(bild);

final = zeros(128,128);

for j = 1:128
    for i = 1:128
        summa = 0;
        counter = 0;
        
       
        for f = -2:1:2
            for q = -2:1:2
                a = i+f;
                b = j+q;
                
                    
                if a < 1 || b < 1 || a > 128 || b > 128
                   
                else
                    counter = counter + 1;
                    
                    v = single(bild(a,b));
                    summa = summa + v;
                
                end
            end
        end   
        final(i,j) = round((summa/counter));
    end
end

final = single(final);
subtract = final - bild;

figure(1)

imagesc(bild); 

figure(2)
imagesc(final); 

figure(3)
imagesc(subtract); 




