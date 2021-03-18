function [y] = resample2(x,p,q,r)
%resample2 aplica la función resample en las dos dimensiones de la matriz x
% en la proporción p/q en vertical y p/r en horizontal
y = resample(x,p,q);
y = resample(y',p,r)';
end

