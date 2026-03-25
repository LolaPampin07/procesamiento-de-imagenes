%% TP1: Ejercicio 13
clc; clear all; close all;
[file,dir]=uigetfile('.bmp;.tif;.jpg;.png');
filename=[dir,file];
info=imfinfo(filename);

switch info.ColorType
    case 'indexed'  %ImOrig.bmp
        [X,map]=imread(filename);
        I=ind2gray(X,map);

    case 'grayscale'
        I=imread(filename);

    case 'truecolor' %m83.bmp
        rgb=imread(filename);
        I=rgb2gray(rgb);
end

%% Operaciones

I_lr = fliplr(I);
I_ud = flipud(I);
I_rot = imrotate(I,180);

figure
imshow(I_lr);
figure
imshow(I_ud);
figure
imshow(I_rot);

figure;
imshow(I);
title('Seleccione el área a recortar');

I_crop = imcrop(I);

figure;
imshow(I_crop);
title('Imagen recortada');
