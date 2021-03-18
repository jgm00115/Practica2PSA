function y = rgbhisteq(x,n)
%rgbhisteq ajusta el contraste de la imagen rgb x mediante la función propia
% de MatLab histeq, calculando la luminancia de la imagen previamente
% INPUT:
%     x: Imagen original a la que vamos a ajustar el contraste
%     n: Número de bins a la hora de realizar histeq
% OUTPUT:
%     y: Imagen resultante

%Separamos las componentes rgb de la imagen
x = double(x)/(2^8-1);
r = x(:,:,1);
g = x(:,:,2);
b = x(:,:,3);
% Obtenemos luminancia y crominancia
Y = 0.299*r + 0.587*g + 0.114*b;
U = 0.492*(b-Y);
V = 0.877*(r-Y);
% Ajustamos el contraste con histeq
L = histeq(Y,n);
% Volvemos a convertir a rgb
b = L + U/0.492;
r = L + V/0.877;
g = L - 0.395*U - 0.581*V;
y(:,:,1) = r;
y(:,:,2) = g;
y(:,:,3) = b;
% Normalizamos y convertimos a uint8
y = uint8(y*(2^8-1));
% Representamos resultados
figure('Name','rgbhisteq');
subplot(221);imshow(x);title('Imagen original');
subplot(222);imshow(y);title('Imagen resultante');
subplot(223);imhist(uint8(Y*255));title('Histograma imagen original');
subplot(224);imhist(uint8(L*255));title('Histograma imagen resultante');
end

