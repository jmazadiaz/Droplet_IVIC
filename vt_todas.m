function [y]=vlimrho(masa, radio, vscdinai, vscdim, vlim)
    k=(rhoai(1)*pi )/(rhoag(1)*(4/3)*pi);
    y=((2*radio))
end



function [vtr ]=vdt(kfls, masa, vscdim, vlim )

     tlim=vlim/9.7767538861216
     max=max(tlim)
     
     tros=linspace(1,max(1),100);
     tama=linspace(1,max(2),100);
     tver=linspace(1,max(3),100);
     tgri=linspace(1,max(4),100);
     tcel=linspace(1,max(5),100);
     tazu=linspace(1,max(6),100);
     tnar=linspace(1,max(7),100);
     tgpq=linspace(1,max(8),100);
         
          
     kfls=6*pi*vscai(1)*radio;
          
     exktm1=exp((-kfls(1)/masa(1))*tros);
     exktm2=exp((-kfls(2)/masa(2))*tama);
     exktm3=exp((-kfls(3)/masa(3))*tver);
     exktm4=exp((-kfls(4)/masa(4))*tgri);
     exktm5=exp((-kfls(5)/masa(5))*tcel);
     exktm6=exp((-kfls(6)/masa(6))*tazu);
     exktm7=exp((-kfls(7)/masa(7))*tnar);
     exktm8=exp((-kfls(8)/masa(8))*tgpq);
     
     vtros=vlim(1)*(1-exktm1);
     vtama=vlim(2)*(1-exktm2);
     vtver=vlim(3)*(1-exktm3);
     vtgri=vlim(4)*(1-exktm4);
     vtcel=vlim(5)*(1-exktm5);
     vtazu=vlim(6)*(1-exktm6);
     vtnar=vlim(7)*(1-exktm7);
     vtgpq=vlim(8)*(1-exktm8);
     
end