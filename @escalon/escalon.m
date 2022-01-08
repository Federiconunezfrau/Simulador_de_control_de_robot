% Constructor para la clase escalon
%
% El escalon tiene los siguientes atributos:
%
%       t_delay: vector de N x 1. "N" es la cantidad de filas de la señal de
%                escalón a generar. Cada fila tiene el delay de cada salida,
%                antes de cambiar de estado bajo a estado alto.
%
%    salida_low: vector de N x 1, contiene los valores de las salidas en estado
%                bajo para los escalones.
%
%   salida_high: vector de N x 1, contiene los valores de las salidas en estado
%                alto para los escalones.
%
% Los métodos para la clase se encuentran en los distintos archivos ".m".
% 
% La función devuelve un objeto escalon.

function u = escalon(td, a_low, a_high)
 
  u.t_delay     = td;
  u.salida_low  = a_low;
  u.salida_high = a_high;
           
  u = class(u, "escalon");
  
endfunction