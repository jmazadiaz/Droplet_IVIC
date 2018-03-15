%%%%    Segment an Image Specifying the Mask

% I=imread('coins.png');
% % imshow(I);
% title('Original Image');
% mask=zeros(size(I));
% mask(25:end-25,25:end-25)=1;
% figure
% % imshow(mask)
% bw= activecontour(I,mask,300);
% imshow(bw)
% title('semented Image')

%%%%%%%%%  

%%%%    Segment Image Overlaying Mask and Contour on Original Image

I=imread('toyobjects.png');
% imshow(I);
mask=false(size(I));

mask(50:150,40:170)=true;
visboundaries(mask,'Color','b');
bw = activecontour(I, mask, 200, 'edge');

visboundaries(mask,'Color','b');
bw = activecontour(I, mask, 200, 'edge');
imshow(bw);


%%%%%%%%%  

%%%%