function theta_norm = normalizar_angulo(theta)
  
  theta_norm = theta;
  
  while(theta_norm > pi)
    theta_norm = theta_norm - 2 * pi;
  endwhile
  
  while(theta_norm <= -pi)
    theta_norm = theta_norm + 2*pi;
  endwhile
 
endfunction