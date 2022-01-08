function dp_out = set_estado_actual(dp, Xt)

  dp_out = dp;
  
  dp_out.X_historico(:,end) = Xt;
  
endfunction