function salida = get_salida(u,t)
  
  salida = [];
  N = rows(u.t_delay);
  
  for i=1:N
    if( t < u.t_delay(i) )
      salida(i,1) = u.salida_low(i);
    else
      salida(i,1) = u.salida_high(i);
    endif
  endfor

endfunction