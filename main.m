%% PRÁCTICA 2 PSA: PROCESAMIENTO 2D DE SEÑALES EN EL DOMINIO ESPACIAL
%% Modificación lineal del contraste de una imagen 
% Con funciones desarrolladas por nosotros mismos
x = imread('lena.tif');
x = rgb2gray(x);
% Aumento del contraste
m = 1.3;
n = -35;
v = contraste(x,m,n);
% Reducción del contraste
m = 0.72;
n = 40;
w = contraste(x,m,n);
figure('Name','Histogramas resultado');
subplot(311);imhist(x);title('Imagen original');
subplot(312);imhist(uint8(v*255));title('Imagen con más contraste');
subplot(313);imhist(uint8(w*255));title('Imagen con menos contraste');
% Con funciones propias de MatLab
I = imread('tire.tif');
% Ecualización de histograma
g = histeq(I,n);
f1 = figure('Name','Original');
subplot(121);imshow(I);title('Imagen original');
subplot(122);imhist(I);title('Histograma imagen original');
f2 = figure('Name','Histeq');
subplot(121);imshow(g);title('Histeq');
subplot(122);imhist(g);title('Histograma histeq');
% Ajuste de los valores de grises automáticamente
z = imadjust(I);
f3 = figure('Name','ImadjustAuto');
subplot(121);imshow(z);title('Imadjust automático');
subplot(122);imhist(z);title('Histograma Imadjust automático');
% Ajuste de los valores de grises manualmente
y = imadjust(I,[],[55,255]/255);
f4 = figure('Name','ImadjustManual');
subplot(121);imshow(y);title('Imadjust manual');
subplot(122);imhist(y);title('Histograma Imadjust manual');
% Equalización de histograma adaptativa
t = adapthisteq(I,'clipLimit',0.06,'Distribution','rayleigh');
f5 = figure('Name','Adapthisteq');
subplot(121);imshow(t);title('Adapthisteq');
subplot(122);imhist(t);title('Histograma adapthisteq');
dock = [f1 f2 f3 f4 f5];
set(dock, 'WindowStyle','Docked');
clear dock f1 f2 f3 f4 f5;
%% resample2
x = rgb2gray(imread('lena.tif'));
x = double(x)/255;  %Normalizamos valores entre 0 y 1
[m,n] = size(x);
fprintf('Imagen original con %i filas y %i columnas\n',m,n);
p = 1;
q = 2;
r = 2;
fprintf('Aplicando resample2 con p = %i, q = %i, r = %i...\n',p,q,r);
y = resample2(x,p,q,r);
[m,n] = size(y);
fprintf('Imagen resultado con %i filas y %i columnas\n',m,n);
figure('Name','Resample2D');
subplot(121);imshow(x);title('Imagen original');
subplot(122);imshow(y);title('Imagen resultante');
% imresize
scale = 16;
v = imresize(x,scale);
figure('Name','Imresize');
subplot(121);imshow(x);title('Imagen original');
subplot(122);imshow(v);title(['Imresize con factor de escalado ' num2str(scale)]);
%% Enmascaramiento 
x = double(imread('lena.tif'))/255;
[Y,U,V] = rgb2YUV(x);
% media en N4
m = 1/3^2.*ones(3);
W = mask(Y,m);
w = YUV2rgb(W,U,V);
% media en N8
m = 1/5^2.*ones(5);
Z = mask(Y,m);
z = YUV2rgb(Z,U,V);
figure('Name','Enmascarado');
subplot(131);imshow(x);title('Imagen Original');
subplot(132);imshow(w);title('Media en N4');
subplot(133);imshow(z);title('Media en N8');
% Media en N8 a las 3 capas rgb vs Luminancia
im(:,:,1) = mask(x(:,:,1),m);
im(:,:,2) = mask(x(:,:,2),m);
im(:,:,3) = mask(x(:,:,3),m);
figure();
subplot(121);imshow(im,[]);title('Media N8 a las 3 capas RGB');
subplot(122);imshow(z);title('Media en N8 solo a Luminancia');
%% Convolución 2D
x = double(imread('coins.png'))/255;
h = 1/5^2*ones(5);
y = conv2D(x,h);
figure('Name','ConvTest');
subplot(121);imshow(x);title('Imagen original x');
subplot(122);imshow(y);title('Imagen resultante y');
[M,N] = size(x);
str1 = sprintf('Imagen original con %i filas y %i columnas',M,N);
[M,N] = size(y);
str2 = sprintf('Imagen resultante con %i filas y %i columnas',M,N);
display(h)
fprintf([str1 '\n' str2 '\n']);
%% Reemplazo de píxel por el máximo de su vecindad
x = double(imread('lena.tif'))/255;
[Y,U,V] = rgb2YUV(x);
% vecindad N4
m = ones(3);
W = maxN(Y,m);
w = YUV2rgb(W,U,V);
% vecindad N8
m = ones(5);
Z = maxN(Y,m);
z = YUV2rgb(Z,U,V);
figure('Name','Enmascarado');
subplot(131);imshow(x);title('Imagen Original');
subplot(132);imshow(w);title('Sustitución en vecindad N4');
subplot(133);imshow(z);title('Sustitución en vecindad N8');
f2 = figure('Name','Histogramas');
subplot(131);imhist(Y);title('Histograma imagen original');
subplot(132);imhist(W);title('Histograma N4');
subplot(133);imhist(Z);title('Histograma N8');
%% Comparación mask y medfilt2
x = double(imread('lena.tif'))/255;
[Y,U,V] = rgb2YUV(x);
% media en N8 con mask
m = 1/5^2.*ones(5);
W = mask(Y,m);
w = YUV2rgb(W,U,V);
% media en N8 con medfilt2
Z = medfilt2(Y,[5 5]);
z = YUV2rgb(Z,U,V);
figure;
subplot(131);imshow(x);title('Imagen original');
subplot(132);imshow(w);title('Resultado con función propia');
subplot(133);imshow(z);title('Resultado con medfilt2');
%% Comparación nMax y ordfilt2
x = double(imread('lena.tif'))/255;
[Y,U,V] = rgb2YUV(x);
% media en N8 con mask
N = 5;
m = ones(N);
W = maxN(Y,m);
w = YUV2rgb(W,U,V);
% media en N8 con medfilt2
Z = ordfilt2(Y,N^2,m);   %%Sustituimos por el píxel con más valor
z = YUV2rgb(Z,U,V);
figure;
subplot(121);imshow(w);title('Resultado con función propia')
subplot(122);imshow(z);title('Resultado con ordfilt2')
%% conv2, filter2, imfilter y fspecial
x = double(imread('coins.png'))/255;
[M,N] = size(x);
fprintf('Dimensiones de x: %ix%i\n',M,N);
h = fspecial('average',5);
[M,N] = size(h);
fprintf('Dimensiones de h: %ix%i\n',M,N);
u = conv2D(x,h);
[M,N] = size(u);
fprintf('Dimensiones de conv2D(x,h): %ix%i\n',M,N);
v = conv2(x,h);
[M,N] = size(v);
fprintf('Dimensiones de conv2(x,h): %ix%i\n',M,N);
w = filter2(h,x); %filter(x,h) no devuelve un resultado correcto
[M,N] = size(w);
fprintf('Dimensiones de filter2(h,x): %ix%i\n',M,N);
z = imfilter(x,h);
[M,N] = size(z);
fprintf('Dimensiones de imfilter(x,h): %ix%i\n',M,N);
figure;
subplot(221);imshow(u);title('Resultado de conv2D')
subplot(222);imshow(v);title('Resultado de conv2')
subplot(223);imshow(w);title('Resultado de filter2')
subplot(224);imshow(z);title('Resultado de imfilter')
%% Comparación conv2D conv2
x = rand(6);display(x);
h = rand(3,2);display(h);
u = conv2D(x,h);display(u);
v = conv2(x,h);display(v);
%% Representación de imágenes en escala de grises con distintos bits
x = imread('coins.png');
b = 6;  %bits con los que queremos representar la imagen
figure;
[y,m] = gray2ind(x,2^b);
subplot(221);imshow(y,m);title(['Imagen representada con ' num2str(b) ' bits']); 
b = 4;
[y,m] = gray2ind(x,2^b);
subplot(222);imshow(y,m);title(['Imagen representada con ' num2str(b) ' bits']);
b = 2;
[y,m] = gray2ind(x,2^b);
subplot(223);imshow(y,m);title(['Imagen representada con ' num2str(b) ' bits']);
b = 1;
[y,m] = gray2ind(x,2^b);
subplot(224);imshow(y,m);title(['Imagen representada con ' num2str(b) ' bits']);