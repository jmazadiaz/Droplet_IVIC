%%%%        Perform 3-D Segmentation Using 2-D Initial Seed Mask
D = load('mri.mat');
A = squeeze(D.D)

seedLevel = 10;
seed = A(:,:,seedLevel) > 75;

figure
imshow(seed);

mask = zeros(size(A));
mask(:,:,seedLevel) = seed;

bw = activecontour(A,mask,300);


figure;
p = patch(isosurface(double(bw)));
p.FaceColor = 'red';
p.EdgeColor = 'none';
daspect([1 1 27/128]);
camlight;
lighting phong