%TP1
%% Lectura de archivo
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

I = im2double(I); %trabaja normalizado
%%
%modifico brillo y contraste de la
R = 0.5 + I*0.25;

%Utilizo el comando imadjust
r_low = min(R(:));
r_high = max(R(:));

S = imadjust(R,[r_low r_high],[0 1]);

i_min = min(I(:));
i_max = max(I(:));
r_min = min(R(:));
r_max = max(R(:));

%% 7)Aplique a una imagen la transformación stretching utilizando el comando imadjust. Grafique ambos histogramas (original y procesado).
