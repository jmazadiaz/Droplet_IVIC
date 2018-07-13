close all

%%
% caso = 'g48-'
% file = strcat('partes_',caso,'.mat');
% 
 visualice_ = 2;
% load(file)
% clear caso file
%%
pause

vi_ = 1;
 end_ = length(Partes);

T_ = ' Tiempo (s) ';
des_ = ' Desplazamiento ';
dia_ = ' Diametro ';
ra_ = ' Radios ';
par_ = ' Num. Particulas '
lan_ = ' lanzamiento Num. '
px_ = ' (px) ';
pa_ = ' Parte A ';
pb_ = ' Parte B ';
pc_ = ' Parte C ';
Title1_ = ' Desplazamiento ';
Title2_ = ' Dinamica Radial ';
Title3_ = ' Borde exterior ';
Title4_ = ' Numero de Particulas por lanzamiento '
D3_ = 'X-Y-T';
vid_ = ' video-';


% plot([Partes{1, 1}.Tiempo_],[Partes{1, 1}.Desplazamiento])
% 
%%                      Parte A

    L1 = 480;     W1 = 390;
    
    L2 =1920 ;    w2 = 960;     c = 1;      d =50;
    
    a1=1 ;     b1=610 ;
    a2=480;    b2=610;
    a3=960 ;   b3=610 ;
    a4=1440 ;  b4=610 ;
    a5=1;   b5=50 ;
    a6=480 ;   b6=50 ;
    a7=960 ;   b7=50 ;
    a8=1440 ;   b8=50 ;

if visualice_ == 1    
    
    for vi_ = 1 : end_
    close all
    
    figure                
    shg
    set(gcf,'position',[a1 b1 L1 W1])
        
        plot([Partes{vi_, 1}.Tiempo_],[Partes{vi_, 1}.Desplazamiento])
        ylabel(strcat(des_,px_)); xlabel(T_);
        title(strcat(Title1_,pa_,' ',vid_,num2str(vi_)));

    figure 
    shg
    set(gcf,'position',[a2 b2 L1 W1])
    
        stem3([Partes{vi_, 1}.Tiempo_],[Partes{vi_, 1}.Des_x],[Partes{vi_, 1}.Des_y])
        xlabel(T_); ylabel(strcat(des_,' X ',px_));  zlabel(strcat(des_,' Y ',px_))
        title(strcat(Title1_ ,' ', D3_ ,' ', pa_));

%%                       Parte B        
    figure 
    shg
    set(gcf,'position',[a3 b3 L1 W1])
    
        plot([Partes{vi_, 2}.Tiempo_],[Partes{vi_, 2}.Desplazamiento])
        ylabel(strcat(des_,px_)); xlabel(T_);
        title(strcat(Title1_,pb_));        
    
     figure 
    shg
    set(gcf,'position',[a4 b4 L1 W1])
    
        stem3([Partes{vi_, 2}.Tiempo_],[Partes{vi_, 2}.Centro_x],[Partes{vi_, 2}.Centro_y])
        xlabel(T_); ylabel(strcat(des_,' X ',px_));  zlabel(strcat(des_,' Y ',px_))
        title(strcat(Title1_ ,' ', D3_ ,' ', pb_));

%%                      Partes C        
    figure 
    shg
    set(gcf,'position',[a5 b5 L1 W1])
    
        scatter([Partes{vi_, 3}.Tiempo_],[Partes{vi_, 3}.Diametro])
        xlabel(T_);            ylabel(strcat(dia_,px_)); 
        title(strcat(Title2_,pc_))     
        
    figure 
    shg
    set(gcf,'position',[a6 b6 L1 W1])
    
        scatter([Partes{vi_, 3}.Tiempo_],[Partes{vi_, 3}.Desplazamiento])
        xlabel(T_);            ylabel(strcat(des_,px_)); 
        title(strcat(Title1_ , pc_));
    
    figure 
    shg
    set(gcf,'position',[a7 b7 L1 W1])
        
        stem(Partes{vi_, 3}(1).Radios)
        xlabel(strcat(ra_,px_))
        title(strcat(Title3_ , pc_));     

%%                      Parte D        
    figure 
    shg
    set(gcf,'position',[a8 b8 L1 W1])
    
        plot(vi_,Partes{vi_,4}.Num_Objetos,'ro')
        ylabel(par_);   xlabel(lan_)
        title(Title4_)
        
    pause
    end        
end

if visualice_ == 2
    figure                
%     shg
%     set(gcf,'position',[c d L2 W2])
    
    for vi_ = 1 : end_
    
        subplot(2,3,1)
        
            plot([Partes{vi_, 2}.Tiempo_],[Partes{vi_, 2}.Desplazamiento])
            ylabel(strcat(des_,px_)); xlabel(T_);
            title(strcat(Title1_,pb_));
            hold on
        
        subplot(2,3,2)
            
            stem3([Partes{vi_, 2}.Tiempo_],[Partes{vi_, 2}.Centro_x],[Partes{vi_, 2}.Centro_y])
            xlabel(T_); ylabel(strcat(des_,' X ',px_));  zlabel(strcat(des_,' Y ',px_))
            title(strcat(Title1_ ,' ', D3_ ,' ', pb_));
            hold on

        subplot(2,3,3)
        
            scatter([Partes{vi_, 3}.Tiempo_],[Partes{vi_, 3}.Diametro])
            xlabel(T_);            ylabel(strcat(dia_,px_)); 
            title(strcat(Title2_,pc_))
            hold on

        subplot(2,3,4)



        subplot(2,3,5)
        
            plot(vi_,Partes{vi_,4}.Num_Objetos,'ro')
            ylabel(par_);   xlabel(lan_)
            title(Title4_)    
            hold on


        subplot(2,3,6)
        
            stem([Partes{vi_, 3}(1).Radios])
            xlabel(T_); ylabel(strcat(des_,' X ',px_));  zlabel(strcat(des_,' Y ',px_))
            title(strcat(Title1_ ,' ', D3_ ,' ', pb_));
        hold on
        pause
    end
end
    
    
%         close figure 1 
%         close figure 2 
%         close figure 3 
%         close figure 4 
%         close figure 5 
%         close figure 6
%         close figure 7
%         close figure 8
% % hold on
    
    
% 
% subplot(2,4,1)
% 
% subplot(2,4,2)

% 

% subplot(2,4,3)

% 
% 
% subplot(2,4,4)
% 
% 

% subplot(2,4,5)
% 
% 
% subplot(2,4,6)
% 
% 
% subplot(2,4,7)
% 
% 
% 
% 
% 
% % 
%     