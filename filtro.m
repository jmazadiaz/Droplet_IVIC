

function bw =filtro(C1)


    bgC1d=imopen(C1,strel('octagon',9));%   Abre la image

    % figure,      subplot(2,1,1),     surf(bgC1d),  subplot(2,1,2),  imshow(bgC1d)

    bgC1d=imcomplement(bgC1d);

    % figure, subplot(2,1,1), surf(bgC1d),  subplot(2,1,2)   imshow(bgC1d)

    bgC1d =bgC1d + 85;

    % figure,  subplot(2,1,1),   surf(bgC1d), subplot(2,1,2),  imshow(bgC1d)
    
    bgC1d_inv=imcomplement(bgC1d);
     
    % figure,    subplot(2,1,1),    surf(bgC1d_inv),     subplot(2,1,2), imshow(bgC1d_inv)

    % CI1a=uint8((double(C1)-double(bgC1d_inv))./2);
    % CI1b=uint8((double(C1)-double(bgC1d_inv))./2);
    CI1c=uint8(double(C1)-double(bgC1d_inv));

    % figure,    subplot(2,3,1), surf(CI1a),    subplot(2,3,2),
    % surf(CI1b),    subplot(2,3,3),    surf(CI1c), subplot(2,3,4),
    % imshow(CI1a),  subplot(2,3,5),    imshow(CI1b),   subplot(2,3,6),  imshow(CI1c)


    la=fspecial('laplacian',.9);        gs=fspecial('gaussian',3,0.1);
    gpl = imfilter(CI1c,gs,'conv');     Lpl = imfilter(gpl,la,'conv');

    LC=uint8(double(CI1c)-5.*double(Lpl));

    Lp_inv=imcomplement(LC);

    BW=binarizacion(Lp_inv,220);
    % BW=imcomplement(BW);
    bw = bwareaopen(BW, 4);

    % figure
    % subplot(2,1,1), surf(Lp_inv),  subplot(2,1,2)
%     imshow(bw)
     
    % figure, subplot(2,1,1), surf(LC), subplot(2,1,2), imshow(Lpl)
     
    % figure, subplot(2,1,1), surf(LC), subplot(2,1,2), imshow(CI1c)

end