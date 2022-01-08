function dp_out = simular_dinamica_mecanismo(dp, T)
  
  dp_out = dp;
  
  X0 = get_estado_actual(dp_out);
  T0 = dp_out.T_historico(end);
  
  [T_out, X_out] = ode45(@(t,x) modeloDinamicoElastico(t,x,dp_out.u,dp_out.mc), [T0 T0+T], X0, dp_out.opt);
  
  dp_out.X_historico = [dp_out.X_historico (X_out.')(:,2:end)];
  dp_out.T_historico = [dp_out.T_historico (T_out.')(2:end)];

endfunction