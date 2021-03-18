function y = maxN(x,m)
% maxN reemplaza el valor de los píxeles por el valor máximo de los vecinos
% que la máscara (kernel) integra.
% INPUT:
%     x: Imagen original
%     m: Máscara a aplicar
% OUTPUT:
%     y: Imagen resultado
[filasM,columnasM] = size(m);
%Si el número de filasM y columnasM es par, la máscara no está centrada
if(rem(filasM,2)== 0 && rem(columnasM,2) == 0)   
    warning('Máscara con %i filasM y %i columnasM, no hay un pixel central',filasM,columnasM);
else
%     Obtenemos el centro de la máscara para ampliar los extremos de la
%     imagen a la que se aplicará la máscara
    Xc = floor(columnasM/2) + 1;
    Yc = floor(filasM/2) + 1;
    y = zeros(size(x));
%     Ampliamos los extremos de la imagen
    temp = zeros(size(x) + [2*(Yc-1) 2*(Xc-1)]);
%     Obtenemos los límites donde se localiza la imagen
    [filas,columnas] = size(temp);
    f1 = Yc;    fend = filas-Yc+1;
    c1 = Xc;    cend = columnas-Xc+1;
    temp(f1:fend,c1:cend) = x;
    x = temp;
%     Recorremos la matriz ampliada aplicando la máscara dentro de los
%     límites donde hay imagen
    for f = f1:fend
        for c = c1:cend
            y(f-Yc+1,c-Xc+1) = max(max(x(f-Yc+1:f+Yc-1,c-Xc+1:c+Xc-1)));
        end
    end
end
end

