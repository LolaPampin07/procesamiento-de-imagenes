%%--------------- Guia 3-----------------------
%% Ejericio 1 --> 1. Genere una señal que sea la suma de dos sinusoides diferentes, calcule su DFT1D grafique el espectro de magnitud.

A1=4; A2=1;
f1=1;f2=6;fc=3; %frecuencia de corte
fm=10*max(f1,f2);

t_span=-1:1/fm:1; %dominio temporal
N= length (t_span); 
f= -fm/2:fm/N:fm/2-fm/N;%dominio frecuencial 

y1 = A1*sin(2*pi*f1*t_span);
y2 = A2*sin(2*pi*f2*t_span);
ys= y1+y2;

tfy1 = fft(y1);
tfy2 = fft(y2);
tfys = fft(ys);

tf1=fftshift(abs(tfy1)/N);
tf2=fftshift(abs(tfy2)/N);
tfs=fftshift(abs(tfys)/N);

figure
subplot (131);plot(t_span, y1,'r', t_span, y2, 'b', t_span, ys,'k');
subplot(132);plot (f, tf1,'r', f, tf2, 'b'); axis([-15 15 0 inf]);
subplot(133);plot(f,tfs,'k');axis([-15 15 0 inf]);
%% Ejercicio 2 --> A la señal del punto 1) agréguele ruido aleatorio y observe como se modifica su espectro de magnitud.
r= rand(1,N)*2; %el nro es las posiciones de la matriz cuadrada de ruido
r=r-mean(r);
y1=y1+r;y2=y2+r;ys=y1+y2;

tfy1 = fft(y1);
tfy2 = fft(y2);
tfys = fft(ys);

tf1=fftshift(abs(tfy1)/N);
tf2=fftshift(abs(tfy2)/N);
tfs=fftshift(abs(tfys)/N);

figure
subplot (221);plot(t_span, r, 'g', t_span, y1,'r', t_span, y2, 'b', t_span, ys,'k');
subplot(222);plot (f, tf1,'r', f, tf2, 'b'); axis([-15 15 0 inf]);
subplot(223);plot(f,tfs,'k');axis([-15 15 0 inf]);
subplot(224);plot (f,fftshift(abs(fft(r)/N)));

%% Ejercicio 3 --> A la señal del punto 2) aplíquele un filtro pasa bajos frecuencial. Antitransforme y visualice los resultados.

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


