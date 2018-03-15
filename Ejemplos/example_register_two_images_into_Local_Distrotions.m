fixed  = bw2;
moving = bw3;
% fixed  = rgb2gray(fixed);
% moving = rgb2gray(moving);
%%%%%       Muesta imagen
% figure
% imshowpair(fixed,moving,'montage')
% figure
% imshowpair(fixed,moving)
%%%%%%

moving = imhistmatch(moving,fixed);
[distan,movingReg] = imregdemons(moving,fixed,[500 400 200],'AccumulatedFieldSmoothing',1.3);

%%%%%%%

figure
imshowpair(fixed,movingReg)
figure

imshowpair(fixed,movingReg,'montage')

%%%    Puede servir para algo