clc; close all; clear all;
%-----------------
% Lectura de imagen
I = imread('circulos_lineas.png');
I = rgb2gray(I);
I = imbinarize(I);
figure
subplot(131); imshow(I); title('Imagen original BW')

%-----------------
% Elemento estructural (DISCO)
% El radio debe ser parecido al tamaño de los círculos
se = strel('disk', 8); % probar con 6, 8, 10 según tamaño

%-----------------
% Apertura morfológica
Io = imopen(I, se);

subplot(132); imshow(Io); title('Apertura (líneas eliminadas)')
