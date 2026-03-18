%TP1: EJ1: lectura y visualización// mapa de color // histograma

%% Lectura de archivo
clc; clear all; close all;
[file,dir]= uigetfile ('*.bpm;*.png;*.png;*.tiff'); %filtro por tipo de archivo
filename=[dir,file]; %obtengo ruta y nombre de archivo
info=imfinfo(filename); % obtengo la metadata del archivo

% conversion a gray scale + grafico + histograma
switch info.ColorType %dependiendo del tipo de imagen abro y convierto a gris
    case 'grayscale'
        I=imread(filename);
        [M,N,p]=size(I);
        figure
        subplot(121);imshow(I)
        subplot(122);imhist(I)
        
    case 'indexed'
        [X, map]=imread(filename);
        [M,N,p]=size(X);
        I=ind2gray(X,map); %convierto a escala de grises
        figure
        subplot(121);imshow(I)
        subplot(122);imhist(I)
    case 'truecolor'
        rgb=imread(filename);
        [M,N,p]=size(rgb);
        I=rgb2gray(rgb);      
end 

%% Transformacion de intensidad
% Ej 4) Complemento/negativo
bits = info.BitDepth/p; % es distinto cuando la imagen es truecolor
O1= (2^bits-1)-I;
O2= imcomplement(I);

figure
subplot(221);imshow(O1)
subplot(222);imhist(O1)
subplot(223);imshow(O2)
subplot(224);imhist(O2)

% Ej 9) Umbralizado
u=128;
for i=1:M
    for j=1:N
        if I(i,j)<u
            O3(i,j)=0;
        else
            O3(i,j)=2^bits-1;
        end
    end
end

O4=I>u;
O4=uint8(O4);
O4=O4*(2^bits-1);

figure
subplot(221);imshow(O3,[]);colorbar
subplot(222);imhist(O3)
subplot(223);imshow(O4,[])
subplot(224);imhist(O4)

%% Resolucion en brillo y Resolucion Espacial

% Ej 5) Utilice el comando imresize para modificar la resolución espacial de una imagen (submuestreo y sobremuestreo).
O5= imresize(I,0.1); %mitad de fila mitad de col

figure
imshow(O5,[]); colorbar

% Ej 6) Utilice el comando grayslice para modificar la resolución en intensidad de una imagen.
O6= grayslice (I,4);

figure
imshow(O6,[]); colorbar