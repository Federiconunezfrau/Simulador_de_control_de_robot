% Modelo dinamico de un doble pendulo con motor y reducción con deformación
% elástica en las juntas
%
% Sintáxis:
%  dxdt = modeloDinamicoElastico(t,x,u,mc)
%
% Parámetros: 
% t: tiempo [s]
% x: vector columna de estados ordenado como 
% 	[q;q_p;thetaM;thetaMp]
%   Las posiciones se miden en rad y las velocidades en rad/s
% u: acción de control expresada en [V], en un rango de -10V a 10V
% mc: masa de la carga transportada en Kg. Se modeliza solo una carga puntual
% ubicada en el origen de la terna 2
%
% Retorno:
% dxdt: derivadas del vector de estado para ser usadas por una ode45

% El vector de variables de estado se define como:
% x=[q qp thetaM thetaMp]
% donde:
% q: variables articulares
% qp: velocidades de los ejes
% thetaM: posición del eje del motor
% thetaMp: velocidad del motor


function dxdt = modeloDinamicoElastico(t,x,u,mc)

flag_simular_comportamiento_elastico = true;

% *************************************************************************
% Definición de la carga
% *************************************************************************
Igczz = 0; % Kg m^2
if nargin<4
    mc = 0;  % Kg
end

g = 9.8;    % Estamos en la Tierra. Modificar para la Luna

% *************************************************************************
% Parámetros cinemáticos del robot
% *************************************************************************
a1 = 0.4;
a2 = 0.3;

% *************************************************************************
% Parámetros dinámicos del robot
% *************************************************************************
%Parametros dinamicos del eslabon 1 sin el motor 2 conectado
Igl1zz = 0.07;
Xgl1 = -a1/2;
Ygl1 = 0;
ml1 = 5;

%Parametros dinamicos del eslabon 2 sin la carga útil
Igl2zz = 0.015;
Xgl2 = -a2/2;
Ygl2 = 0;
ml2 = 1;

% Efecto de las masas de los motores
mm2 = 1.7;        % Kg
Igm2zz = mm2*(.11/2)^2;  % Kg m^2

% Parámetros dinámicos para el eslabón 1 con la carcaza del motor 2
% calculados al origen de la terna del eslabón. Se supone que el motor 1
% está fijado al eslabón 2.
I01zz = (Igl1zz + ml1 * (Xgl1^2+Ygl1^2)) + (Igm2zz);
Xg1 = ((Xgl1*ml1) + (0*mm2))/(ml1+mm2);
Yg1 = ((Ygl1*ml1) + (0*mm2))/(ml1+mm2);
m1 = ml1 + mm2;

% Parámetros dinámicos para el eslabón 2 con la carga colgada en el origen
% de la terna 2, calculados al origen de la terna 2
I02zz = (Igl2zz + ml2 * (Xgl2^2+Ygl2^2)) + (Igczz);
Xg2 = ((Xgl2*ml2) + (0*mm2))/(ml2+mc);
Yg2 = ((Ygl2*ml2) + (0*mm2))/(ml2+mc);
m2 = ml2 + mc;

% *************************************************************************
% Parametros de los motores
% *************************************************************************
% VALORES del manual de Kollmorgen
Jm = 0.395/10000*eye(2,2);      % [Kg m²] == 0.395 Kg cm²
Bm = 0.000275*eye(2,2);         % [Nm/(rad/s)]
N = 100*eye(2,2);
Fm = 0*2.8/100*eye(2,2);        % [Nm]
TorqM_max = 56.2/100;           % [Nm]
Km = 7.6/100*eye(2) * 8.6/10;   % [Nm/V]

% *************************************************************************
% Parametros de la elasticidad de la junta
% *************************************************************************
Ke = [2500 0;0 500];%*5;
Be = eye(2,2)/5;

% *************************************************************************
% Conversion de variables
% *************************************************************************
q = x(1:2,1);
qp = x(3:4,1);
thetaM = x(5:6,1);
thetaMp = x(7:8,1);

%**************************************************************************
% CALCULO DE LAS MATRICES DE LA DINAMICA
%**************************************************************************
%CALCULO DE LA MATRIZ M
M(2,2) = I02zz + 2*a2*Xg2*m2 + a2^2*m2;
M(2,1) = M(2,2) + a1* ((a2+Xg2)*cos(q(2))-Yg2*sin(q(2)))*m2;
M(1,2) = M(2,1);
M(1,1) = I01zz + 2*a1*Xg1*m1 + a1^2*(m1+m2) + 2*M(1,2) - M(2,2);

% CALCULO DE LA MATRIZ C
dm11dt2 = -2*a1*m2*((a2+Xg2)*sin(q(2))+Yg2*cos(q(2)));
dm12dt2 = dm11dt2/2;
C = [0.5*dm11dt2*qp(2) 0.5*dm11dt2*qp(1)+dm12dt2*qp(2);-0.5*dm11dt2*qp(1) 0];

%CALCULO DE LA MATRIZ G
G(2,1) = m2*g*((Xg2 + a2)*cos(q(1)+q(2))- Yg2*sin(q(1)+q(2)));
G(1,1) = m1*g*((Xg1 + a1)*cos(q(1))- Yg1*sin(q(1))) + m2*g*a1*cos(q(1)) + G(2,1);

%**************************************************************************
% CALCULO DE LAS DERIVADAS DE LOS ESTADOS
%**************************************************************************
% Calculo del torque motor
TorqM = Km*u;

% Saturación del actuador
idx_sat = (abs(TorqM)>TorqM_max);
TorqM(idx_sat) = TorqM_max*sign(TorqM(idx_sat));

if flag_simular_comportamiento_elastico
    % Calculo la reduccion de las transmisiones
    R = inv(N);
    % Calculo el torque transmitido a traves de la junta elastica
    tau_e = Ke*(R*thetaM - q) + Be*(R*thetaMp - qp);
    % Calculo la aceleración de las variables articulares del mecanismo con el
    % modelo directo
    q2p = inv(M)*( tau_e - C*qp -G);
    % Calculo la aceleración en las variables del motor
    thetaM2p = inv(Jm)*(TorqM - Bm*thetaMp -Fm*tanh(10*thetaMp) - R*tau_e );
else
    q2p = inv(M+Jm*N^2)*( N*TorqM -Bm*N^2*qp - C*qp -G);
    thetaMp = N*qp;
    thetaM2p = N*q2p;
end

dxdt = [qp; q2p;thetaMp;thetaM2p];
end
