% ==============================================================================
% loop de simulación

t = 0;

t_acum              = [t];
senial_control_acum = [u0];

while(t < T - sim_step)

  t = t + sim_step;
  
  % se calcula la señal de control
  senial_control = get_salida(u,t);
  
  doble_pendulo = set_entrada(doble_pendulo, senial_control);
  doble_pendulo = simular_dinamica_mecanismo(doble_pendulo, sim_step);
  
  senial_control_acum = [senial_control_acum get_entrada(doble_pendulo)];
  t_acum              = [t_acum t];
  
endwhile 

[X,T_pendulo] = get_historico(doble_pendulo);