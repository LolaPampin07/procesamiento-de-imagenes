%TP1 EJERCICIO12
%% Lectura de imagenes
clc; clear all; close all;
[file,dir]=uigetfile('.bmp;.tif;.jpg;.png');
filename=[dir,file];
infoA=imfinfo(filename);
A=imread(filename);%fondo

[file,dir]=uigetfile('.bmp;.tif;.jpg;.png');
filename=[dir,file];
infoB=imfinfo(filename);
B=imread(filename); %objeto

%% Chequeo tamanios
[MB,NB, p] = size(B);

A = imresize(A,[MB NB]);

%% Umbralizado
figure
imhist(B), title('Histo original'); axis tight
u=200;
ix = find(B >= u);
Bumb = uint8(zeros(size(B)));
Bumb(ix) = 1;

ix = find(B >= u);
BumbInv = uint8(ones(size(B)));
BumbInv(ix) = 0;

%% Cara sola
C = B .* BumbInv; %cara sola
figure
imshow(C);

%% Fondo solo
F = A .* Bumb;
figure
imshow(F);

%% Total
T = C + F;
figure
imshow(T);

