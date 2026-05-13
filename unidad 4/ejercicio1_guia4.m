clc; clear all; close all;

% --- SELECCIÓN DE IMAGEN ---
[file, dir] = uigetfile('*.bmp;*.png;*.jpg;*.tiff;*.tif', 'Seleccione una imagen'); 
filename = [dir, file]; 
info = imfinfo(filename); 

% Procesamiento según el tipo de color de la metadata
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
In = I;

% --- MENÚ DE RUIDO ---
sel = menu('Ruido', '1) Gaussiano', '2) Rayleigh', '3) Exponencial', ...
    '4) Sal y Pimienta', '5) Pimienta', '6) Sal');

switch sel
    case 1 % Gaussiano
        a = input('ingrese el valor medio [0,1]: ');
        b = input('ingrese el desvío estandar [0,1]: ');
        R = a + b * randn(M, N);
        In = I + R;
        In = max(min(In, 1), 0); % Clampeo
        ruido = 'Gaussiano';

    case 2 % Rayleigh
        a = input('ingrese el valor de a: ');
        b = input('ingrese el valor de b (>0): ');
        R = a + sqrt(-b * log(1 - rand(M, N)));
        In = I + R;
        In = max(min(In, 1), 0);
        ruido = 'Rayleigh';

    case 3 % Exponencial
        a = input('ingrese el valor de a (>0): ');
        if a <= 0, error('El parámetro debe ser positivo'); return; end
        k = -1/a;
        R = k * log(1 - rand(M, N));
        In = I + R;
        In = max(min(In, 1), 0);
        ruido = 'Exponencial';

    case 4 % Sal y Pimienta
        Pa = input('Ingrese Pa ([0,1]): ');
        Pb = input('Ingrese Pb ([0,1]): ');
        R = ruido_sal_pimienta(M, N, Pa, Pb);
        In = I;
        ix1 = find(R == 0); In(ix1) = 0;
        ix2 = find(R == 1); In(ix2) = 1;
        ruido = 'sal y pimienta';

    case 5 % Pimienta
        Pa = input('Ingrese Pa (Pb = 0): ');
        R = ruido_sal_pimienta(M, N, Pa, 0);
        In = I;
        ix = find(R == 0); In(ix) = 0;
        ruido = 'pimienta';

    case 6 % Sal
        Pb = input('Ingrese Pb (Pa = 0): ');
        R = ruido_sal_pimienta(M, N, 0, Pb);
        In = I;
        ix = find(R == 1); In(ix) = 1;
        ruido = 'sal';
end

% --- VISUALIZACIÓN ---
figure
subplot(131); imshow(I); title('Imagen original')
subplot(132); imshow(In); title(['Ruido ', ruido])
subplot(133); hist(R(:), 25); title(['Histograma ruido ', ruido])