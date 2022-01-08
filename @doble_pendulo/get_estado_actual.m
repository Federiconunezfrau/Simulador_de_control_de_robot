% Getter de la clase doble péndulo, devuelve el último vector de estados
% calculado.
% 
% dp: objeto de clase doble péndulo.
%
% Devuelve el último elemento del atributo X_historico. Este elemento es el
% estado actual del doble péndulo.

function X = get_estado_actual(dp)
  
  X = dp.X_historico(:,end);
  
endfunction