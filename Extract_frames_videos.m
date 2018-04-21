%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Este script permite extraer los cuadros de una lista de videos
% enumerados a partir de su raiz y su extensión. Y guardarlos en una carpeta
% ~IMG\video-#\ que el mismo crea.  
%                                                                        
%    " raiz_vid = 'XXXX'  "  COLOCAR LA RAIZ DE LOS VIDEOS
%    " ext = '.XXX'     "  COLOCAR LA TEXTENSIÓN DE LOS VIDEOS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

folder ='D:\Droplets Video\glicerina\48 cm\AVI\'
r_vid ='g48-'
ext  = '.avi'

mkdir(strcat(folder,'IMG'));
mesg='Porcentaje de la tarea  :  ';

for i = 1: 30
    vfile = strcat(folder,r_vid,num2str(i),ext);
    dir  = strcat(folder,'IMG\img-',r_vid,num2str(i));
    
    porcentaje= floor(i/30*100);
    
    mkdir(dir)
    
    if true
        vidObj = VideoReader(vfile);
        read(vidObj, Inf);
    end
    
           
    for  img = 1:vidObj.NumberOfFrames;
        
         if img>100
                add='\f';
         end
         if img<=99
                add='\f0';
         end
         if img<=9
            add='\f00';
         end
          
            filename = strcat(dir,add,num2str(img),'.jpg');
            tempimg = read(vidObj,img); 
           % tempgray = rgb2gray(tempimg);%                                     Convertir en Ggray
           % imwrite(imfilter(tempgray,fspecial('log',[6 6],1)),filename);%     Con filtro gausiano y lapalciano
            imwrite(tempimg,filename);
    end
    
   strcat(mesg,num2str(porcentaje), ' %') 
end 



