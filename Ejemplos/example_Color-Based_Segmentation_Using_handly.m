%Color-Based Segmentation Using the L*a*b* Color Space%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Access a Matrox(R) frame grabber attached to a Pulnix TMC-9700 camera, and
% acquire data using an NTSC format.  
% vidobj = videoinput('matrox',1,'M_NTSC_RGB');

% Open a live preview window.  Point camera onto a piece of colorful fabric.
% preview(vidobj);

% Capture one frame of data.
% fabric = getsnapshot(vidobj);
% imwrite(fabric,'fabric.png','png');

% Delete and clear associated variables.
% delete(vidobj)
% clear vidobj;

%%    Step 1: Acquire Image

fabric = imread('D:\Droplets Video\glicerina\48 cm\AVI\IMG\img-g48-1\f001.jpg');
figure(1), imshow(fabric), title('fabric');

%%     Step 2: Calculate Sample Colors in L*a*b* Color Space for Each Region

%load regioncoordinates; % Es para encontrar un color en la region (reg...nates)

nColors = 1;  % por que hay 6 regiones en reg...nates, 
sample_regions = false([size(fabric,1) size(fabric,2)]); % inisicializo  la variable 


  % sample_regions(:,:) = roipoly(fabric)% Hay que hacerlo antes
load sample_regions

imshow(sample_regions),title('sample region');

lab_fabric = rgb2lab(fabric);%      Convert your fabric RGB image into an L*a*b* image using rgb2lab .


a = lab_fabric(:,:,2);  %           Calculate the mean 'a*' and 'b*' value for each area that you extracted with roipoly. These values serve as your color markers in 'a*b*' space.
b = lab_fabric(:,:,3);
color_markers = zeros([nColors, 2]);

% % color_markers =  zeros(1);

for count = 1:nColors
  color_markers(count,1) = mean2(a(sample_regions(:,:,count)));
  color_markers(count,2) = mean2(b(sample_regions(:,:,count)));
end


% % color_markers(1) = mean2(fabric1(sample_regions(:,:)));

fprintf('[%0.3f,%0.3f] \n',color_markers(1),color_markers(2)); %    For example, the average color of the red sample region in 'a*b*' space is

% % fprintf('[%0.3f] \n',color_markers)

%%    Step 3: Classify Each Pixel Using the Nearest Neighbor Rule

    %Each color marker now has an 'a*' and a 'b*' value. 
    %Create an array that contains your color labels, i.e., 0 = background, 1 = red, 2 = green, 3 = purple, 4 = magenta, and 5 = yellow.
 
color_labels = 0:nColors-1;


a = double(a);% Convertir matrices to be used in the nearest neighbor classification.
b = double(b);
distance = zeros([size(a), nColors]);

for count = 1:nColors
  distance(:,:,count) = ( (a - color_markers(count,1)).^2 + ...
                      (b - color_markers(count,2)).^2 ).^0.5;
end

[~, label] = min(distance,[],3);
label = color_labels(label);
clear distanc

%%    Step 4: Display Results of Nearest Neighbor Classification

rgb_label = repmat(label,[1 1 3]);
segmented_images = zeros([size(fabric), nColors],'uint8');

for count = 1:nColors
  color = fabric;
  color(rgb_label ~= color_labels(count)) = 0;
  segmented_images(:,:,:,count) = color;
end 

imshow(segmented_images(:,:,2)), title('red objects');
%%
imshow(segmented_images(:,:,3)), title('green objects');

%%
purple = [119/255 73/255 152/255];
plot_labels = {'k', 'r', 'g', purple, 'm', 'y'};

figure
for count = 1:nColors
  plot(a(label==count-1),b(label==count-1),'.','MarkerEdgeColor', ...
       plot_labels{count}, 'MarkerFaceColor', plot_labels{count});
  hold on;
end
  
title('Scatterplot of the segmented pixels in ''a*b*'' space');
xlabel('''a*'' values');
ylabel('''b*'' values');

