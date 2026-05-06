% Imagen 2D con degradé sinusoidal horizontal
% Las columnas siguen una sinusoide y las filas son idénticas

clear; close all; clc;

% Parámetros
Nfilas = 256;   % número de filas
Ncols  = 256;   % número de columnas
f = 10;          % frecuencia de la sinusoide (ciclos)

% Señal sinusoidal 1D (horizontal)
n = 0:Ncols-1;                     
senal = sin(2*pi*f*n/Ncols);

% Crear imagen replicando la señal en filas
imagen = repmat(senal, Nfilas, 1);

% Normalizar para visualización
imagen_norm = mat2gray(imagen);

% Mostrar imagen
figure
imagesc(imagen_norm)
colormap gray
colorbar
axis image
title('Imagen con degradé sinusoidal horizontal')



%% --- FFT 2D ---
F = fftshift(fft2(imagen));
mag = abs(F);

% Ejes de frecuencia espacial (normalizados)
fx = (-Ncols/2 : Ncols/2-1)/Ncols;   % eje horizontal
fy = (-Nfilas/2 : Nfilas/2-1)/Nfilas;% eje vertical

%% --- Espectro de magnitud ---
figure
imagesc(fx, fy, log(1 + mag))
colormap gray
colorbar
axis image
xlabel('Frecuencia horizontal')
ylabel('Frecuencia vertical')
title('Espectro de magnitud (log)')

% Limitar eje horizontal a [-f/2 , f/2]
xlim([-0.5 0.5])

%% Esprecto de frecuencias de una imagen
% ABRIR IMAGEN
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
% --- FFT 2D ---
F = fftshift(fft2(I));
mag = abs(F);

% Obtener tamaño real de la imagen
[M, N] = size(I);

% Ejes de frecuencia espacial normalizados
fx = (-N/2 : N/2-1) / N;    % frecuencia horizontal
fy = (-M/2 : M/2-1) / M; % frecuencia vertical

% Graficar espectro de magnitud
figure
colormap gray
colorbar
axis image
xlabel('Frecuencia horizontal (ciclos/píxel)')
ylabel('Frecuencia vertical (ciclos/píxel)')
title('Espectro de magnitud (log)')

%% Filtro pasa bajo
[M, N] = size(I);
[fx,fy]=frecspan([M,N], 'meshgrid');
for i=1:1:length(fc)
    if f(i)>=-fc &&f(i)<=fc
        h(i)=1;
    else
        h(i)=0;
    end
end
prod = fft(ys).*ifftshift(h); %esprecto crudo de la suma por el filtro pasabajo descentrado
o1=real(ifft(prod));

figure
subplot(121);plot(f,h);axis([-10 10 0 2]);
subplot(122); plot (t_span,y1,'ro',t_span, o1,'bo')
