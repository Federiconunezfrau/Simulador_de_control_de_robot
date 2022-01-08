close all;
clear all;
clc;

% ==============================================================================
% Configuración del simulador

T = 10;           % Duración de la simulación, en segundos

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

% ==============================================================================
% loop de simulación

N_steps = floor(T / sim_step); % cantidad de pasos de simulación

u = ones(2,N_steps);

t = 0;

for i = 1:N_steps

  t = t + sim_step;
  
  doble_pendulo = set_entrada(doble_pendulo, u(:,i));
  doble_pendulo = simular_dinamica_mecanismo(doble_pendulo, sim_step);
  
endfor 

[X,T] = get_historico(doble_pendulo);