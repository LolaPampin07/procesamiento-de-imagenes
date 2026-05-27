% Guia 5: Ej 1: Generación de elementos estructurales (SE)

% diamante
se1 = strel('diamond',2); %devuelve una estructura con 2 campos
A = sel.Neighborhood %vemos el contenido del campo vecindad
figure;colormap(gray(2));image(A)

%disco
%SE = strel('disk',r,n) --> SE disk-shaped, r radius, n number of line
%structuring elements used to approximate the disk shape
se2 = strel('disk',5,0);
B = se2.Neighborhood
figure;colormap(gray(2));image(B)

%linea
se3 = strel('line',5,90); %Len: distancia Euclidea del centro a los extremos de la linea, angle=90
C = se3.Neighborhood

%rectángulo
se4 = strel('rectangle',[2,5]);
D = se4.Neighborhood

%cuadrado
se5 = strel('square',3);
E = se5.Neighborhood

%forma arbitraria
X = [0 1 0;
    1 0 1;
    0 1 0];

se6 = strel('arbitrary', X);
F = se6.Neighborhood

figure;colormap(gray);imagesc(A)
