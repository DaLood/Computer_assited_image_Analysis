%%
%Q1
close all; 
I = imread('cameraman.png');
filter = fspecial("average", [3 3]);
filter = fspecial('laplacian', 0.2);
filter3 = fspecial('gaussian',[7 7], 2);
c = imfilter(I,filter,"same");
c2 = imfilter(I,filter, "same");
c3 = imfilter(I, filter3, "same");

impulse = [0,0,0; 0,1,0; 0, 0, 0];
hp = impulse - filter;
c4 = imfilter(I, hp, "same");
br = filter + filter;
bp  = impulse - br;
c5 = imfilter(I,bp, "same");


imshow(I)
figure
imshow(c)
figure
imshow(c2)
figure
imshow(c3)
figure
imshow(c4)
figure
imshow(c5)

%%
%Q2
close all; clear;
I = imread('cameraman.png');
I2 = imread('wagon.png');
filterY = fspecial('sobel');
filterX = filterY';
filter_lap = fspecial('laplacian');

cX = imfilter(I,filterX, "same");
cY = imfilter(I,filterY, "same");
c_lap = imfilter(I, filter_lap, "same");

sobel = cX + cY;
imshow(sobel)
figure
imshow(c_lap)

%%
%Q3
close all; clear;
I = imread('wagon_shot_noise.png');

median_filtered = medfilt2(I, [3 3]);
mean = fspecial('average', [3 3]);
gauss = fspecial('gaussian',[3 3]);

c_m = imfilter(I,mean, "same");
c_g = imfilter(I, gauss, "same");


imshow(median_filtered)
figure
imshow(c_m)
figure
imshow(c_g)
figure
imshow(I)

%%
%Q3 part 2
close all; clear all;
H = fspecial('disk',3);
I = imread('wagon.png');

ny = zeros(260,394);

for i = 2:259
    for j = 2:393
        matrix = zeros(3,3);
          for f = -1:1        % Getting 3x3 kernal
               for q = -1:1
                    matrix(f+2, q+2) = I(i+f,j+q);
               end
          ny(i,j) = median(median(matrix));
          end
    end
end

subplot(3,1,1)
imagesc(I)
K= medfilt2(I);
subplot(3,1,2)
imagesc(K)
title('Matlabs egna')
subplot(3,1,3)
imagesc(ny)
title('Vår kod')

%%
%Q4
close all; clear;
I = double(imread('lines.png'));
camera = double(imread('cameraman.png'));

f  = fftshift(fft2(I));
f_cam = fftshift(fft2(camera));
% Problem 12
camera_copy = camera;
f_cam_copy = fftshift(fft2(camera_copy));
f_cam_copy(20:30, 50:60) = 0;
f_cam_copy(226:236, 206:216) = 0;


imagesc(I)
figure
imagesc(log(abs(f)))
title('Log amp of Lines')
figure
imagesc(camera)
figure
imagesc(log(abs(f_cam)))
title('Log amp of Camera Man')
figure
imagesc(log(abs(f_cam_copy)))
figure
imshow(ifft2(f_cam_copy))


%%
%Q4 part 2
close all; clear;
f = fftshift(fft2(rand(1,5)));
f(1,2) = 0;
% When only setting f(1,2)=0 --> compelx values
f(1,4) = 0;
% When also setting f(1,4)=0 --> reel values
% Always zero-out freq. symmetric to get real values
image = ifft2(ifftshift(f));
imshow(image)
% odd length vector
%f = 0.628 - 0.297i	-0.566 - 0.661i	3.153 + 0i	-0.566 + 0.661i	0.628 + 0.297i
% pair 1,5 = + reel and one has -&+ imag. , Pair 2,4 : - reel and one has -&+ imag.
% If an even length vector = only reel values and no symmetry
% The center value f(1,3) donesn't have any imaginary part : 3.153310