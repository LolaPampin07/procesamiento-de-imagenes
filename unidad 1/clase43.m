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
        
        figure
        subplot(121);imshow(I)
        subplot(122);imhist(I)
        
    case 'indexed'
        [X, map]=imread(filename);
        I=ind2gray(X,map); %convierto a escala de grises
        figure
        subplot(121);imshow(I)
        subplot(122);imhist(I)
    case 'truecolor'
        rgb=imread(filename);
        I=rgb2gray(rgb);      
end 


%% Brillo

k=input('ingrese el valor de k');
O=I+k;
figure
subplot(121);imshow(O)
subplot(122);imhist(O)

%% Contraste  --> la imagen se comprime o se dilata

a=input('ingrese el valor de alpha');
O=I*a; % 0<a<1 = comprime // a>1 =dilata
figure
subplot(121);imshow(O)
subplot(122);imhist(O)

% valor minimo y maximo --> me sirve para calcular el contraste inicial y final
min(I(:)); %minimo de toda la imagen
max (I(:));

%% Transformacion de intensidad
% Ej 4) Complemento/negativo
[M,N,p]=size(I);
bits = info.BitDepth/p; % es distinto cuando la imagen es truecolor
O1= -I+(2^bits -1);
O2= imcomplement(I);

figure
subplot(221);imshow(O1)
subplot(222);imhist(O1)
subplot(223);imshow(O2)
subplot(224);imhist(O2)

% Ej 9) Umbralizado
u=128;


            

