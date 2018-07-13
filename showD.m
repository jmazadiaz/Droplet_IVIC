figure 
    shg
        L = 1200;
        W = 1200;
        a=10;
        b=10;
        set(gcf,'position',[a b L W])
    
        imshow(d_figi2_)
    
        figure                
       
        shg
        L = 1060;
        W = 1000;
        a=850;
        b=10;
        set(gcf,'position',[a b L W])
       
        
        part_ =1;
        if length(is2maxpos) <= 4
            
            subplot(2,2,1)
                imshow([cell2mat(s_ibw(1,1+part_)),])
                hold on
                 title(['Numero de objetos: ',num2str(icc.NumObjects)])
    %               plot(iTcentroids(1),iTcentroids(2),'*b')
                    title([num2str(icc.NumObjects),'objetos - ','fragmento ',num2str(1+part_)])
                hold off
            subplot(2,2,2)
                imshow(cell2mat(s_ibw(1,2+part_)))
                hold on
    %               plot(iTcentroids(1),iTcentroids(2),'*b')
                    title(['fragmento ',num2str(2+part_)])
                hold off
            subplot(2,2,3)
                imshow(cell2mat(s_ibw(1,3+part_)))
                hold on
    %                plot(i2Tcentroids(1),i2Tcentroids(2),'*b')
                    title(['fragmento ',num2str(3+part_)])
                    hold off
            subplot(2,2,4)
                imshow(cell2mat(s_ibw(1,4+part_)))
                hold on
                    title(['fragmento ',num2str(4+part_)])
                    title(['Carpeta ',video_,num2str(num_)])
                hold off
        end
    %%      
        if length(is2maxpos) <= 6
            
            subplot(2,3,1)
                imshow(cell2mat(s_ibw(1,1+part_)))
                hold on
    %               plot(iTcentroids(1),iTcentroids(2),'*b')
                    title([num2str(icc.NumObjects),'objetos - ','fragmento ',num2str(1+part_)])
                hold off
            subplot(2,3,2)
                imshow(cell2mat(s_ibw(1,2+part_)))
                hold on
    %               plot(iTcentroids(1),iTcentroids(2),'*b')
                   title(['fragmento ',num2str(2+part_)])
                hold off
            subplot(2,3,3)
                imshow(cell2mat(s_ibw(1,3+part_)))
                hold on
    %                plot(i2Tcentroids(1),i2Tcentroids(2),'*b')
                    title(['Numero de objetos: ',num2str(icc.NumObjects)])
                hold off
            subplot(2,3,4)
                imshow(cell2mat(s_ibw(1,4+part_)))
                hold on
    %               plot(jTcentroids(1),jTcentroids(2),'*r')
                    title(['fragmento ',num2str(4+part_)])
                hold off
            subplot(2,3,5)
                imshow(cell2mat(s_ibw(1,5+part_)))
                hold on
    %               plot(jTcentroids(1),jTcentroids(2),'*r')
                     title(['fragmento ',num2str(5+part_)])
                hold off
            subplot(2,3,6)
                imshow(cell2mat(s_ibw(1,6+part_)))
                hold on
    %               plot(jTcentroids(1),jTcentroids(2),'*r')
                    title(['fragmento ',num2str(6+part_)])      
                hold off    
        end
    %%
    if length(is2maxpos) >= 9
            
            subplot(3,3,1)
                imshow([cell2mat(s_ibw(1,1+part_)),cell2mat(s_ibw(1,2+part_));cell2mat(s_ibw(1,3+part_)),cell2mat(s_ibw(1,4+part_))])
                hold on
    %               plot(iTcentroids(1),iTcentroids(2),'*b')
                    title([num2str(d_icc.NumObjects),'objetos - ','  fragmento ',num2str(1+part_),num2str(2+part_),';',num2str(3+part_),num2str(4+part_)])
                hold off
            subplot(3,3,2)
                imshow([cell2mat(s_ibw(1,5+part_)),cell2mat(s_ibw(1,6+part_));cell2mat(s_ibw(1,7+part_)),cell2mat(s_ibw(1,8+part_))])
                hold on
    %               plot(iTcentroids(1),iTcentroids(2),'*b')
                    title(['fragmento ',num2str(5+part_),num2str(6+part_),';',num2str(7+part_),num2str(8+part_)])
                hold off
            subplot(3,3,3)
                imshow([cell2mat(s_ibw(1,9+part_)),cell2mat(s_ibw(1,10+part_));cell2mat(s_ibw(1,11+part_)),cell2mat(s_ibw(1,12+part_))])
                hold on
    %                plot(i2Tcentroids(1),i2Tcentroids(2),'*b')
                     title(['fragmento ',num2str(9+part_),num2str(10+part_),';',num2str(11+part_),num2str(12+part_)])
                hold off
            subplot(3,3,4)
                imshow([cell2mat(s_ibw(1,13+part_)),cell2mat(s_ibw(1,14+part_));cell2mat(s_ibw(1,15+part_)),cell2mat(s_ibw(1,16+part_))])
                hold on
    %               plot(jTcentroids(1),jTcentroids(2),'*r')
                    title(['fragmento ',num2str(13+part_),num2str(14+part_),';',num2str(15+part_),num2str(16+part_)])
                hold off
            subplot(3,3,5)
                imshow([cell2mat(s_ibw(1,17+part_)),cell2mat(s_ibw(1,18+part_));cell2mat(s_ibw(1,19+part_)),cell2mat(s_ibw(1,20+part_))])
                hold on
    %               plot(jTcentroids(1),jTcentroids(2),'*r')
                    title(['fragmento ',num2str(17+part_),num2str(18+part_),';',num2str(19+part_),num2str(20+part_)])
                hold off
            subplot(3,3,6)
                imshow([cell2mat(s_ibw(1,21+part_)),cell2mat(s_ibw(1,22+part_));cell2mat(s_ibw(1,23+part_)),cell2mat(s_ibw(1,24+part_))])
                hold on
    %               plot(jTcentroids(1),jTcentroids(2),'*r')
                    title(['fragmento ',num2str(21+part_),num2str(22+part_),';',num2str(23+part_),num2str(24+part_)])
                hold off
            subplot(3,3,7)
                imshow([cell2mat(s_ibw(1,25+part_)),cell2mat(s_ibw(1,26+part_));cell2mat(s_ibw(1,27+part_)),cell2mat(s_ibw(1,28+part_))])
                hold on
    %               plot(jTcentroids(1),jTcentroids(2),'*r')
                     title(['fragmento ',num2str(25+part_),num2str(26+part_),';',num2str(27+part_),num2str(28+part_)])
                hold off
            subplot(3,3,8)
                imshow([cell2mat(s_ibw(1,29+part_)),cell2mat(s_ibw(1,30+part_));cell2mat(s_ibw(1,31+part_)),cell2mat(s_ibw(1,32+part_))])
                hold on
    %               plot(jTcentroids(1),jTcentroids(2),'*r')
                    title(['fragmento ',num2str(29+part_),num2str(30+part_),';',num2str(31+part_),num2str(32+part_)])
                hold off
            subplot(3,3,9)
                imshow([cell2mat(s_ibw(1,33+part_)),cell2mat(s_ibw(1,34+part_));cell2mat(s_ibw(1,35+part_)),cell2mat(s_ibw(1,36+part_))])
                hold on
    %               plot(jTcentroids(1),jTcentroids(2),'*r')
                    title(['fragmento ',num2str(33+part_),num2str(34+part_),';',num2str(35+part_),num2str(36+part_)])
                hold off                
        end
        