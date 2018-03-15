I = imread('rice.png');
imshow(I)
background = imopen(I,strel('disk',15));
figure
surf(double(background(1:8:end,1:8:end))),zlim([0 255]);
set(gca,'ydir','reverse');
I2 = I - background;
imshow(I2);


I3 = imadjust(I2);
imshow(I3);

bw=binarizacion(I3,70);
%   bw3 = imcomplement(bw1);;

threshold = graythresh(I3);
bw=im2bw(I3,threshold);

bw = bwareaopen(bw, 50);
imshow(bw);

cc=bwconncomp(bw, 8);

cc.NumObjects

grain = false(size(bw));
grain(cc.PixelIdxList{35}) = true;
imshow(grain);


labeled = labelmatrix(cc);
RGB_label = label2rgb(labeled, @spring, 'c', 'shuffle');
imshow(RGB_label)

graindata = regionprops(cc, 'basic');
grain_areas = [graindata.Area];
grain = false(size(bw));
grain(cc.PixelIdxList{idx}) = true;
imshow(grain);