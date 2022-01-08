##opt.legend    = {'q1','q2'};
##opt.trace     = {'b-','r-'};
##opt.linewidth = 2;
##opt.grid      = true;
##opt.fontsize  = 15;
##opt.title     = 'Evolución de las variables articulares';
##opt.xlabel    = 'tiempo [s]';
##opt.ylabel    = 'q [°]';
##
##graficar_XY([T;T],X(1:2,:) * 180/pi, opt);

% gráfico de las variables articulares del doble péndulo
figure
hold on;
X_norm = X;
for i = 1:length(X(1,:))
  X_norm(1,i) = normalizar_angulo(X(1,i));
  X_norm(2,i) = normalizar_angulo(X(2,i));
endfor
plot( T, X_norm(1,:) * 180/pi, 'b-','linewidth',2);
hold on;
plot( T, X_norm(2,:) * 180/pi, 'r-','linewidth',2);
grid on;
legend('q1','q2');
title('Evolución de las variables articulares');
xlabel('tiempo[s]');
ylabel('q[°]');
set(gca, 'FontSize', 15);