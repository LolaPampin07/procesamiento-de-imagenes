%Guía 4: Ej5 - Ruido impulsivo, filtro de mediana y de mediana adaptativo
clc, close all;clear all

[file, dir] = uigetfile('*.bmp;*.png;*.jpg;*.tiff;*.tif', 'Seleccione una imagen'); 
filename = [dir, file]; 
info = imfinfo(filename);

switch info.ColorType
    case 'indexed'
        [I, map] = imread(filename);
        I = ind2gray(I, map);
    case 'grayscale'
        I = imread(filename);
    case 'truecolor'
        I = imread(filename);
        I = rgb2gray(I);
end

I=im2double(I);

In=imnoise(I,"salt & pepper", 0.6);

Om = medfilt2(In,[11 11]); %mediana
Oa = filtro_mediana_adaptativo(In, 11); %mediana adaptativo

figure
subplot(221);imshow(I);title('Imagen Original')
subplot(222);imshow(In);title('Imagen Con Ruido Impulsivo')
subplot(223);imshow(Om,[]);title('Filtrado con mediana')
subplot(224);imshow(Oa,[]);title('Filtrado con mediana adaptativo')