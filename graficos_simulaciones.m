% Se extrae la evolución del vector de estados
q1 = X(1,:);
q2 = X(2,:);

% gráfico de las variables articulares del doble péndulo
figure
hold on;
q1_norm = q1;
q2_norm = q2;
for i = 1:length(q1)
  q1_norm(i) = normalizar_angulo(q1(i));
  q2_norm(i) = normalizar_angulo(q2(i));
endfor
plot( T_pendulo, q1_norm * 180/pi, 'b-','linewidth',2);
hold on;
plot( T_pendulo, q2_norm * 180/pi, 'r-','linewidth',2);
grid on;
legend('q1','q2');
title('Evolución de las variables articulares');
xlabel('tiempo[s]');
ylabel('q[°]');
set(gca, 'FontSize', 15);
set(gca, 'ytick', -180:20:180);
set(gca, 'xtick', T_pendulo(1):0.5:T_pendulo(end)+1);

% grafico de la señal de control del doble péndulo
figure
hold on;
plot( t_acum, senial_control_acum(1,:), 'b-','linewidth',2);
hold on;
plot( t_acum, senial_control_acum(2,:), 'r-','linewidth',2);
grid on;
legend('u1','u2');
title('Señales de control del doble péndulo');
xlabel('tiempo[s]');
ylabel('u [V]');
set(gca, 'FontSize', 15);
set(gca, 'ytick', 0:0.1:1);
set(gca, 'xtick', T_pendulo(1):0.5:T_pendulo(end)+1);