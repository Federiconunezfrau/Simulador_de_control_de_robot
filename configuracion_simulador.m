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

% se crea la señal de control para el doble péndulo
u = pulso([0;0],[1;1],[0;0],[1;1]);
