function [P2 Tform]  = transform(imgFix_FNames,imgMov_FNames)

imagen_mov=imread(imgMov_FNames);
imagen_fix=imread(imgFix_FNames);

    [iF_Points, iD_boardSize, ~] = detectCheckerboardPoints(imgFix_FNames);
    [iM_Points, ~ , ~] = detectCheckerboardPoints(imgMov_FNames);

    iM_p = esquinas(iM_Points);
    iF_p = esquinas(iF_Points);

    xmin = min(iF_p(:,1));
    xmax = max(iF_p(:,1));

    ymin = min(iF_p(:,2));
    ymax = max(iF_p(:,2));

Tform = forma(iF_p,iM_p);

P2=imtransform(imagen_mov,Tform,'XData',[xmin xmax],'YData',[ymin ymax]);

clear xmin xmax ymin ymax  imagen_fix iF_Points...
      iM_Points iM_p iF_p 

end