% A las imágenes con ruido generadas en el punto 1), aplíquele diferentes filtros de media.

sel = menu('Filtros de Mediana', '1) Media Armónica', '2) Media Contra-Armónica', '3) Filtro Mediana', ...
    '4) Filtro de Mínima', '5) Mediana Adaptativo');

m=3;
n=3;

switch sel
    case 1 %Media Armónica
        O=colfilt(In,[m,n],'sliding',@media_armonica);
        filtro = 'media armónica';

    case 2 %Media Contra-Armónica
        Q = input('Ingrese el valor de Q: ');
        O=colfilt(In,[m,n],'sliding',@media_contra_armonica, Q);
        filtro = 'media contra-armónica';

    case 3 %Filtro mediana
        O = medfilt2(In,[m,n]);
        filtro = 'mediana';

    case 4 %Filtro de mínima
        O = colfilt(In,[m,n],"sliding",@filtro_minimo);
        filtro = 'de mínima';

    case 5 %Filtro de medina adaptativo
        O = filtro_mediana_adaptativo(In,21);
        filtro = 'adaptativo de mediana';

end

% clampeo los valores de la imagen de salida al intervalo [0,1]
O = max(min(O,1),0);

figure
subplot(221); imshow(O); title(['Imagen con filtro ', filtro])
subplot(222); imshow(In); title(['Imagen con Ruido ', ruido])
subplot(223); hist(O(:), 255); title('Histograma Imagen filtrada')
subplot(224); hist(In(:), 255); title('Histograma Imagen con ruido')

