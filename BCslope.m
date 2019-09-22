%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    BCslope.m
%   Input 
%       frac_all = Lista de todos las imagenes
%       form = La forma analizada (Esqueleto, Mancha o Perimetro)
%       type = Si quiero Dimension fractal o conteo de cajas                (Mejorar No tiene que ser 4)
%       caso = Cadena de caracteres para los titulos 
%       
%   Output
%       grad = Calculo de la dimension fractal y el conteo de cajas
%       
%  Apartir de una imagen binaria calcula el numero de cahas y la dimensión
%  fractal de la image escogida, en form (1 = Macha rellena,2 = Esqueleto o 
%  3 = Perimetro de la mancha). luego de acurdo a al tipo de analisis
%  obtenemos  los gráficos del conteo de cajas o la dimension fractal con
%  los caracteres que contenga la variable casos.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function grad = BCslope(frac_all,form,type,caso)
if      form == 1                                                           % Extraigo las imagenes de acuerodo a la forma escogida
    n = {frac_all.NBoxF};       r = {frac_all.RBoxF};                   
elseif  form == 2
    n = {frac_all.NBoxE};       r = {frac_all.RBoxE};
elseif  form == 3
    n = {frac_all.NBoxR};       r = {frac_all.RBoxR};
else
    error('Solo: 1 = Fill 2 = End 3 = Remove');
end
     

 if type == 2                                                               % Calculo y muestra las cajas o los gradientes de acuerdo a type 
     for vid_ = 1: length(frac_all)
        s=-gradient(log(n{vid_}))./gradient(log(r{vid_}));
        semilogx(r{vid_}, s, 's-');
        ylim([0.7 2]);
        hold on
     end
 xlabel('r, Tamaño de caja'); ylabel('- d ln n / d ln r, Dimensión local');
 title([num2str(2) 'D Conteo de cajas' ': '  caso]);
     
 elseif type ==1
     for vid_ = 1: length(frac_all)
      loglog(r{vid_},n{vid_},'s-');
      hold on
     end
        xlabel('r, Tamaño de caja'); ylabel('n(r), Numero de cajas');
        title([num2str(2) 'D Conteo de cajas ' ': ' caso]);
 elseif type == 4
     for i = 1:30
        n_m(i,1:9) = n{1,i};        r_m(i,1:9) = r{1,i};
     end
     n_mean = mean(n_m,1);     r_mean = mean(r_m,1);
%      sn_men = std(n_m,1)       sr_mean = std(r_m,1);
     
        s=-gradient(log(n_mean))./gradient(log(r_mean));
        semilogx(r_mean, s, 's-');
        ylim([0.70 2.00]);
 xlabel('r, Tamaño de caja'); ylabel('- d ln n / d ln r, Dimensión local');
 title([num2str(2) 'D Conteo de cajas' ': '  caso]);
     
 elseif type == 3
     for i = 1:30
        n_m(i,1:9) = n{1,i};        r_m(i,1:9) = r{1,i};
     end
     n_mean = mean(n_m,1);     r_mean = mean(r_m,1);
%      sn_men = std(n_m,1)       sr_mean = std(r_m,1);
     
     loglog(r_mean,n_mean,'s-');
     
      xlabel('r, Tamaño de caja'); ylabel('n(r), Numero de cajas');
        title([num2str(2) 'D Conteo de cajas ' ': ' caso]);
 end
end