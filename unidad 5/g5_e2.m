%Guia 5, Ej 2: dilatación y erosión
clc, close all;clear all,

%------------
% Dilatación
I = imread('letras.png');
I = rgb2gray(I);
I = im2double(I);
% figure, imshow(I)

%Obs: las imágenes tienen que tener objetos en blanco (o grises) y fondo
%negro

Ic = imcomplement(I);
% figure, imshow(Ic)

% Ic = imbinarize(Ic); % si quiero trabajar con BW binarizo la imagen
% grayscale

%Defino el elemento estructural: forma arbitraria (cruz)
X = [0 1 0;
    1 1 1;
    0 1 0];

se = strel("arbitrary", X)
% si es gray puedo trabajar igual con un SE plano

% operador dilatación
Id = imdilate(Ic, se); % por default es 'same'
% se puede aplicar varias veces el mismo SE --> [se,se]

figure;
subplot(221);imshow(I);title('Imagen Original')
subplot(222);imshow(Ic);title('Complemento de la imagen original')
subplot(2,2,[3 4]);imshow(Id);title('Imagen dilatada')

%-----------------
%Erosión
I = imread('cuadraditos.tif'); %Imagen gray, el cuadrado más grande tiene 20x19
I = im2double(I);

%defino el elemento estructural
se = strel('square', 18)
Ie = imerode(I,se);

figure
subplot(121);imshow(I);title('Imagen Original')
subplot(122);imshow(Ie);title('Imagen erosionada')

%otro ejemplo circuito
I=imread('circuito.tif'); %Imagen BW

se1=strel('disk',5);
se2=strel('disk',10);
se3=strel('disk',30);

Ie1=imerode(I,se1);
Ie2=imerode(I,se2);
Ie3=imerode(I,se3);

figure
subplot(221);imshow(I);title('Imagen original')
subplot(222);imshow(Ie1);title('Imagen erosionada disco R=5')
subplot(223);imshow(Ie2);title('Imagen erosionada disco R=10')
subplot(224);imshow(Ie3);title('Imagen erosionada disco R=30')