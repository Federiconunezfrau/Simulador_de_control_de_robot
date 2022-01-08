close all;
clear all;
clc;

% ==============================================================================
% Configuración del simulador

T = 10.0;           % Duración de la simulación, en segundos

sim_step = 10e-3; % paso de tiempo máximo para simular la dinámica del doble 
                  % péndulo    
                 

% Condiciones iniciales del doble péndulo
q_0       = [-pi/2 ; 0];
qp_0      = [  0   ; 0];
thetaM_0  =  q_0 * 100;
thetapM_0 = [  0     ; 0];

X0 = [ q_0        ; 
       qp_0       ;
       thetaM_0   ; 
       thetapM_0 ];

mc0 = 0;        % carga que lleva el péndulo, en Kg

u0 = [ 0 ; 0 ]; % señal de control de entrada, en V

% se crea el objeto doble péndulo
doble_pendulo = doble_pendulo(X0, u0, mc0, sim_step);

#u = escalon([5;0],[0;0],[1;1]);
u = pulso([0;0],[1;1],[0;0],[1;1]);

% ==============================================================================
% loop de simulación

N_steps = floor(T / sim_step); % cantidad de pasos de simulación
senial_control_acum = [u0];

t = 0;
t_acum = [t];

while(t < T - sim_step)

  t = t + sim_step;
  
  % se calcula la señal de control
  senial_control = get_salida(u,t);
  
  doble_pendulo = set_entrada(doble_pendulo, senial_control);
  doble_pendulo = simular_dinamica_mecanismo(doble_pendulo, sim_step);
  
  senial_control_acum = [senial_control_acum senial_control];
  t_acum              = [t_acum t];
  
endwhile 

[X,T_pendulo] = get_historico(doble_pendulo);