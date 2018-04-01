clear 
clc
close all

% clear tform f_Points fixed fixedPoints fixet m_Points moving movingPoints registered

imgFix_FNames={'C:\Users\Nexus\Desktop\Cuadricula\cuadricula-a-R.bmp',...
                    'C:\Users\Nexus\Desktop\Cuadricula\cuadricula-b-R.bmp.png',...
                    'C:\Users\Nexus\Desktop\Cuadricula\cuadricula-c-R.png',...
                    'C:\Users\Nexus\Desktop\Cuadricula\cuadricula-d-R.png',...
                    'C:\Users\Nexus\Desktop\Cuadricula\cuadricula-e-R.png',...
                    'C:\Users\Nexus\Desktop\Cuadricula\cuadricula-f-R.png',...
                    'C:\Users\Nexus\Desktop\Cuadricula\cuadricula-g-R.png'};
                
% imgFix_ind=imgFix_FileNames(1);               
                
% img_FileNames={'C:\Users\Nexus\Desktop\Cuadricula\cuadricula-a.bmp',...
%                     'C:\Users\Nexus\Desktop\Cuadricula\cuadricula-b.bmp',...
%                     'C:\Users\Nexus\Desktop\Cuadricula\cuadricula-c.bmp',...
%                     'C:\Users\Nexus\Desktop\Cuadricula\cuadricula-c.bmp',...
%                     'C:\Users\Nexus\Desktop\Cuadricula\cuadricula-e.bmp',...
%                     'C:\Users\Nexus\Desktop\Cuadricula\cuadricula-f.bmp',...
%                     'C:\Users\Nexus\Desktop\Cuadricula\cuadricula-g.bmp'}

imgMov_FileNames = dir('C:\Users\Nexus\Desktop\Cuadricula\cuadricula48G\*.png');

for i_=1:length(imgMov_FileNames)
 imgMov_FNames{i_} = strcat('C:\Users\Nexus\Desktop\Cuadricula\cuadricula48G\',imgMov_FileNames(i_).name);
end
clear imgMov_FileNames i_;


        % 
        % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % %       LEE LAS IMAGENES QUE VOY A ANALIZAR
        % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % 
        % imagen_mov=imread(imgMov_FNames{1});
        % imagen_fix=imread(imgFix_FNames{1});
        % 
        % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % %       CALIbRACION DE LA CAMARA Y LA LENTE, ME JODI LAS CUADRICULA
        % %       Aunque puedo Juntar varias cuadriculas-a para hacer el conjunto de
        % %       calibración
        % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % 
        %     % [imagePoints, boardSize, imagesUsed] =
        %     % detectCheckerboardPoints(imgFix_ind);
        %     %
        %     % %       Muestra los puntos detecatados en cada imagen % for i_ = 1:6 % I
        %     % = imread(imgFix_FileNames{1,i_}); % subplot(3, 2, i_); %  imshow(I); hold
        %     % on; plot(imagePoints(:,1,i_), imagePoints(:,2,i_), 'ro'); % end
        %     %
        %     % imgF_FileNames = imgFix_ind(imagesUsed);
        %     %
        %     % squareSize = 5.08; worldPoints = generateCheckerboardPoints(boardSize,
        %     % squareSize);
        %     %
        %     %
        %     % [cameraParams, imagesUsed, estimationErrors] =
        %     % estimateCameraParameters(imagePoints,...
        %     %                                                 worldPoints,'EstimateSkew',
        %     %                                                 false, ...
        %     %                                                 'EstimateTangentialDistortion',
        %     %                                                 false, ...
        %     %                                                 'NumRadialDistortionCoefficients',
        %     %                                                 2, ... 'WorldUnits',
        %     %                                                 'mm');
        %     %
        %     % J1 = undistortImage(imagen,cameraParams);
        %     %
        %     % figure, imshow(J1);
        %     %
        %     % for i=1:7
        %     %     imagen=J1; J1 = undistortImage(imagen,cameraParams);
        %     % %     imshow(J1); end
        %     %   figure;imshow(J1);
        % 
        %     %
        %     % %Se muestra la imágen.
        %     
        % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % %       DETECTAR LOS PUNTOS DEL CUADRO DE AJEDREZ y Sus Esquinas
        % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % 
        % [iF_Points, iD_boardSize, ~] = detectCheckerboardPoints(imgFix_FNames{1});
        % [iM_Points, ~ , ~] = detectCheckerboardPoints(imgMov_FNames{1});
        % 
        % iM_p = esquinas(iM_Points);
        % iF_p = esquinas(iF_Points);
        % 
        % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % %       CONVERTIDO EN FUNCIÓN esquinas.m
        % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % 
        % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % %       MUESTRA DE LOS AVANCES HASTA ACA
        % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %     % figure;imshow(imagen_mov);
        %     % hold on
        %     % plot(iM_p(:,1),iM_p(:,2),'*r')
        %     % title( 'Imagen movida' )
        %     % 
        %     % figure;imshow(imagen_fix);
        %     % hold on
        %     % plot(iF_p(:,1),iF_p(:,2),'*r')
        %     % title( 'Imagen Fija' )
        % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % %       TRANSFORMACIÓN
        % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % 
        % xmin = min(iF_p(:,1));
        % xmax = max(iF_p(:,1));
        % 
        % ymin = min(iF_p(:,2));
        % ymax = max(iF_p(:,2));
        % 
        % Tform = forma(iF_p,iM_p);
        % 
        % P2=imtransform(imagen_mov,Tform,'XData',[xmin xmax],'YData',[ymin ymax]);
        
[P2 Tform]  = transform(imgFix_FNames{1},imgMov_FNames{1});

figure,
imshow(P2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   CONVERTIDO EN FUNCION forma.m
% [X Y] = ginput(4);
% 
% [X Y] = ordenarCoordenadasEnSentidoHorario( X, Y );

% figure; imshow(imagen_fix)
% [x y] = ginput(4);

% [x y] = ordenarCoordenadasEnSentidoHorario( x, y );


%  x=[1;210;210;1];
%  y=[1;1;297;297];
% 
% A=zeros(8,8);
% A(1,:)=[XM(1),YM(1),1,0,0,0,-1*XM(1)*XF(1),-1*YM(1)*XF(1)];
% A(2,:)=[0,0,0,XM(1),YM(1),1,-1*XM(1)*YF(1),-1*YM(1)*YF(1)];
% 
% A(3,:)=[XM(2),YM(2),1,0,0,0,-1*XM(2)*XF(2),-1*YM(2)*XF(2)];
% A(4,:)=[0,0,0,XM(2),YM(2),1,-1*XM(2)*YF(2),-1*YM(2)*YF(2)];
% 
% A(5,:)=[XM(3),YM(3),1,0,0,0,-1*XM(3)*XF(3),-1*YM(3)*XF(3)];
% A(6,:)=[0,0,0,XM(3),YM(3),1,-1*XM(3)*YF(3),-1*YM(3)*YF(3)];
% 
% A(7,:)=[XM(4),YM(4),1,0,0,0,-1*XM(4)*XF(4),-1*YM(4)*XF(4)];
% A(8,:)=[0,0,0,XM(4),YM(4),1,-1*XM(4)*YF(4),-1*YM(4)*YF(4)];
% 
% v=[XF(1);YF(1);XF(2);YF(2);XF(3);YF(3);XF(4);YF(4)];
% 
% u=A\v;
% 
% U=reshape([u;1],3,3)';
% 
% T=maketform('projective',U');
% 
% P2=imtransform(imagen_mov,T,'XData',[1 210],'YData',[1 297]);


% 
% fixed=C1;
% moving=C2;
% 
% % iptsetpref('ImshowAxesVisible','on')
% % imshow(moving)
% 
% 
%  movingPointsAdjusted = cpcorr(m_Points,f_Points,moving,fixed);
% % 8750000000000
% % 
% %  f_Points=[37 92;167 39;89 221];
% %  m_Points=[37 92;167 39;89 221];
%  
% tform = fitgeotrans(movingPointsAdjusted, f_Points, 'affine');
% 
% registered = imwarp(moving, tform,'FillValues', 255);
% 
% % figure, imshow(registered);
% 
% figure, imshowpair(fixed,registered,'blend');

% figure
% subplot(1,2,1)
% imshow(fixed)
% hold on
% plot(f_Points(:,1),f_Points(:,2),'+b')
% subplot(1,2,2)
% imshow(moving)
% hold on
% plot(m_Points(:,1),m_Points(:,2),'+b')
