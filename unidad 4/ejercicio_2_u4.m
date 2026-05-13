%% Guía 4 - Ejercicio 2: Ruido Periódico y Filtrado
clc; clear all; close all;

% Carga y conversión
[file, dir] = uigetfile({'*.bmp;*.tif;*.jpg'}, 'Seleccione el billete');
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

I = im2double(I);
[M, N] = size(I);

% Genero ruido periódico
C = [0 10]; % Coordenadas de los impulsos
A = [1];  % Amplitudes
[r, R, S] = imnoise3(M, N, C, A);

% Sumo la DFT "cruda"
T = fft2(I);
TT = T + ifftshift(R);
In = real(ifft2(TT));

% Análisis de espectros
TF = fftshift(log(abs(T) + 1));
TTF = fftshift(log(abs(TT) + 1));

% Visualización inicial
figure;
subplot(321); imshow(I, []);
subplot(322); imshow(In, []);
subplot(323); imshow(TF, []);
subplot(324); imshow(TTF, []);
subplot(325); mesh(TF);
subplot(326); mesh(TTF);

% Diseño del Filtro Notch
m = max(TTF(:));
umbral = 0.95 * m;
H = ones(size(I));
ix = find(TTF >= umbral);
H(ix) = 0;

% Aplicación del filtro y reconstrucción
prod = TTF .* H;
p = TT .* ifftshift(H);
O = real(ifft2(p));

% Resultado Final
figure;
subplot(131); imshow(I, []); title('Imagen original');
subplot(132); imshow(O, []); title('Imagen filtrada (O)');
subplot(133); imshow(prod, []); title('Espectro filtrado');