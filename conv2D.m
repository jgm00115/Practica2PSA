function y = conv2D(x,h)
% conv2D realiza la convolución en 2D de las matrices x y h empleando el
% algoritmo de la transformada de fourier discreta estudiado en TCT
% INPUT:
%     x: matriz de entrada
%     h: matriz de respuesta del filtro
% OUTPUT:
%     y: matriz de salida
[K,L] = size(x);
[Q,P] = size(h);
% la matriz y tendrá N filas y M columnas, que se obtienen como:
N = K + Q - 1;
M = L + P - 1;
% Ajustamos el tamaño de x y h concatenando 0
x = [x zeros(K,M-L)];
x = [x;zeros(N-K,M)];
h = [h zeros(Q,M-P)];
h = [h;zeros(N-Q,M)];
% Calculamos y como un vector 1D
y = ifft(fft(reshape(x,1,[])).*fft(reshape(h,1,[])));
% Reordenamos el vector introduciendo los elementos por columnas
y = reshape(y,N,M);
end

