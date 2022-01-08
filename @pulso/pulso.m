% Constructor para la clase pulso
%
% El pulso tiene los siguientes atributos:
%
%       t_delay: vector de N x 1. "N" es la cantidad de filas de la señal de
%                pulso a generar. Cada fila tiene el delay de cada salida,
%                antes de cambiar de estado bajo a estado alto.
%
%       t_ancho: vector de N x 1. Cada fila tiene el ancho del pulso de cada
%                salida.
%
%    salida_low: vector de N x 1, contiene los valores de las salidas en estado
%                bajo para los pulsos.
%
%   salida_high: vector de N x 1, contiene los valores de las salidas en estado
%                alto para los pulsos.
%
% Los métodos para la clase se encuentran en los distintos archivos ".m".
% 
% La función devuelve un objeto pulso.

function u = pulso(td, ancho, a_low, a_high)
 
  u.t_delay     = td;
  u.t_ancho     = ancho;
  u.salida_low  = a_low;
  u.salida_high = a_high;
           
  u = class(u, "pulso");
  
endfunction