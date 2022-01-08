% Constructor para la clase doble péndulo
%
% El doble péndulo tiene los siguientes atributos:
%
%   X_historico: matriz de 8 x N, cada fila guarda el histórico de las 8
%                componentes del vector de estados a lo largo de la simulación.
%
%   T_historico: vector de 1 x N, contiene los instantes de tiempo sobre los que
%                se calculó el vector de estados.
%
%             u:  vector de 2 x 1, contiene la señal de control en para cada
%                 eje.          
%
%             mc: valor en Kg de la masa puntual que carga el doble péndulo.
%
%            opt: para simular la dinámica del doble péndulo se utiliza
%                 la función ode45. Este atributo contiene la información de 
%                 la configuración para utilizar llamar a ode45.
%
% Los métodos para la clase se encuentran en los distintos archivos ".m".
% 
% La función devuelve un objeto doble péndulo.

function dp = doble_pendulo(X0,u0,mc0,Ts) 
  
  dp.X_historico   = [ X0 ];
  dp.T_historico   = [  0 ];
  
  dp.u             = u0;
  dp.mc            = mc0;
  
  dp.opt = odeset('RelTol',0.001,'AbsTol',0.001,'InitialStep',Ts/20,'MaxStep',Ts);
           
  dp = class(dp, "doble_pendulo");
  
endfunction