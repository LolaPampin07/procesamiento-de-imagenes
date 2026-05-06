%% Parte II: Transformada de Fourier Discreta 2D
clc; clear all; close all;

%% --- Abrir imagen ---
[file,dir] = uigetfile('.bmp;.tif;.jpg;.png');
filename = [dir,file];
info = imfinfo(filename);

switch info.ColorType
    case 'indexed'
        [X,map] = imread(filename);
        I = ind2gray(X,map);

    case 'grayscale'
        I = imread(filename);

    case 'truecolor'
        rgb = imread(filename);
        I = rgb2gray(rgb);
end

I = im2double(I);   % trabajar en double

%% --- FFT 2D ---
F = fftshift(fft2(I));
mag = abs(F);

% Tamaño de la imagen
[Nfilas, Ncols] = size(I);

% Ejes de frecuencia espacial normalizados
fx = (-Ncols/2:Ncols/2-1) / Ncols;
fy = (-Nfilas/2:Nfilas/2-1) / Nfilas;

%% --- Filtro pasa bajos ideal ---
[FX, FY] = meshgrid(fx, fy);
R = sqrt(FX.^2 + FY.^2);

fc = 0.15;                 % frecuencia de corte (ajustable)
H = double(R <= fc);       % filtro ideal

% Aplicar filtro en frecuencia
Ff = F .* H;

% Imagen filtrada (anti-transformada)
If = real(ifft2(ifftshift(Ff)));

% --- Subplot 2x2 ---
figure

% 1. Imagen original
subplot(2,2,1)
imshow(I, [])
title('Imagen original')

% 2. Espectro de magnitud
subplot(2,2,2)
imagesc(fx, fy, log(1 + mag))
axis image
colormap gray
colorbar
title('Espectro de magnitud (log)')
xlabel('Frecuencia horizontal')
ylabel('Frecuencia vertical')

% 3. Espectro luego del filtrado
subplot(2,2,3)
imagesc(fx, fy, log(1 + abs(Ff)))
axis image
colormap gray
colorbar
title('Espectro filtrado (log)')
xlabel('Frecuencia horizontal')
ylabel('Frecuencia vertical')

% 4. Imagen reconstruida
subplot(2,2,4)
imshow(If, [])
title('Imagen filtrada (IFFT)')


%% --- Filtros Gaussianos en frecuencia ---


% Mallado de frecuencias
[FX, FY] = meshgrid(fx, fy);
R2 = FX.^2 + FY.^2;


% Parámetro del Gaussiano
sigma = 0.08;   % control del corte frecuencial (ajustable)

% --- Pasa bajos Gaussiano ---
H_PB_G = exp(-R2 / (2*sigma^2));

% --- Pasa altos Gaussiano ---
H_PA_G = 1 - H_PB_G;

figure

subplot(2,2,1)
imagesc(fx, fy, H_PB_G)
axis image
colormap jet
colorbar
title('Filtro Pasa Bajos Gaussiano')

subplot(2,2,2)
imagesc(fx, fy, H_PA_G)
axis image
colormap jet
colorbar
title('Filtro Pasa Altos Gaussiano')