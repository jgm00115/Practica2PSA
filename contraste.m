function [y] = contraste(x,m,n)
% contraste ajusta el contraste de la imagen x relacionando el brillo de la
% imagen original con el brillo de la imagen de salida y.
% Input:
%     x:  imagen
%     m:  pendiente de la recta brillo_entrada frente a brillo de salida
%     n:  valor de brillo de salida correspondiente a un nivel de brillo de
%         entrada de 0
% Output:
%     y:  imagen resultante

%Normalizamos el brillo de la imagen de entrada entre 0 y 1
x = double(x)/(2^8-1);
n = n/(2^8-1);
%Calculamos el brillo de la imagen y
y = m*x+n;
%Ajustamos los niveles de brillo que queden fuera de límites
y(y > 1) = 1;
y(y < 0) = 0;
%Representamos los resultados
figure('Name','AjusteContraste');
subplot(221);imshow(x);title('Imagen original');
subplot(223);imshow(y);title('Imagen resultante');
brillo_in = linspace(0,1,256);
brillo_out = m*brillo_in + n;
brillo_out(brillo_out > 1) = 1;brillo_out(brillo_out < 0) = 0;
subplot(122);plot(uint8(brillo_in*(2^8-1)),'--k');hold on;plot(brillo_out*(2^8-1),'b');grid minor;
title('Brillo de entrada frente a brillo de salida');
xlabel('Brillo de entrada');ylabel('Brillo de salida');axis([0,2^8-1,0,2^8-1]);
end

