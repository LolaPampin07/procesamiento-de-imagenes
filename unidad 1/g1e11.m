%TP1, Ej13: Binarización Otsu vs Sauvola
clc;close all;clear all

%abro la imagen sauvola.jpg
rgb=imread('sauvola.jpg');
I=rgb2gray(rgb);        

%Otsu
umbral=graythresh(I);
O1=im2bw(I,umbral);
 
%Usando el script sauvola.m
%BW = SAUVOLA(IMAGE, [M N], THRESHOLD, PADDING)
k = 0.2
O2=sauvola(I,[11 11],k); %default: vecindad 3x3, k=0.34 y padding=replicate 

%Sauvola usando la fórmula
[f,c]=size(I);
I=im2double(I);

for i=2:f-1  %ojo, la primer columna y la primer fila tienen todos ceros..hay que eliminarlos luego
    for j=2:c-1
        w=I(i-1:i+1,j-1:j+1); %defino la ventana de análisis móvil
        media(i,j)=mean(w(:));
        desvio(i,j)=std(w(:));              
    end
end

%elimino la primer fila y primer columna
M = media(2:end,2:end);
S = desvio(2:end,2:end);

r = max(desvio(:));
U= M.*(1+k*((S/r)-1));

O2m=(I(2:end-1,2:end-1)>U); %binarizo teniendo en cuenta el umbral

figure
subplot(221);imshow(I); title('Imagen original')
subplot(222);imshow(O1);title('Otsu')
subplot(223);imshow(O2);title('Sauvola con comando')
subplot(224);imshow(O2m);title('Sauvola a mano')