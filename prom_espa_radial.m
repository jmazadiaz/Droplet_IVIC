close all
% clear

prom_ = true
copy_ = false
%%
% caso = '0A48'
% file = strcat('partes\partes_',caso,'.mat');
%%
file_ =  dir('partes\*.mat');

if copy_ == true
for i_file_ = 1: length(file_)
    
file = strcat('partes\',file_(i_file_).name);
    
load(file)


end_ = length(Partes);

    for video_ = 1:end_
       lpart(video_) = length([Partes{video_, 3}.Tiempo_]);
    end

      [lmax_ imax_] = max(lpart);
      Diametros = zeros(lmax_,end_);

    for video_ = 1:end_
      if lpart(video_) == lmax_
        for instante_ = 1:lpart(video_)
          Diametros(1:lmax_,video_) = [Partes{video_, 3}(1:lmax_).Diametro]';
        end
      else
        diff_ = lmax_ - lpart(video_);
        for instante_ =  1: lpart(video_)
          Diametros(instante_+diff_,video_) = Partes{video_, 3}(instante_).Diametro';
        end
      end
    end

vel_radial(i_file_,1:2) = {file_(i_file_).name(8:11),Diametros};
clear  file diff_ instante_ Diametros lpart video_ Partes lmax_  imax_ end_ i_file_
end
end

if prom_ == true

for caso_ = 1: length(vel_radial)
    [fil ,col] = size(vel_radial{caso_,2});
     t_elemt_(fil,1) =0;
     t_sum_(fil,1) = 0;
   for fila = 1:fil
     for columna = 1:col
       if vel_radial{caso_,2}(fila,columna)~= 0
        t_elemt_(fila,1) = t_elemt_(fila) + 1;
        t_sum_(fila,1) = t_sum_(fila) + vel_radial{caso_,2}(fila, columna);
        tiempo(fila,1) =  1/5400* (fila-1);
       end
     end
   end
   
   dispersion(:,1) = std(vel_radial{caso_,2}');
   d_cuad(:,1) = dispersion.*dispersion;
   espar_radial = t_sum_./t_elemt_;
   
   prom_espa{caso_,1} = vel_radial{caso_,1};
   prom_espa{caso_,2}  = table(tiempo,espar_radial,dispersion,d_cuad);
   
   clear t_elemt_ t_sum_ tiempo dispersion d_cuad espar_radial  
end

for caso_ = 1:length(prom_espa)
subplot(3,4,caso_)
scatter(prom_espa{caso_, 2}.tiempo,...
        prom_espa{caso_, 2}.espar_radial,...
        prom_espa{caso_, 2}.d_cuad,'d')
end

end








