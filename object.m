function bwfigure = object(bw3 ,PixelIdxList)
bwfigure=false(size(bw3));
bwfigure(PixelIdxList) = true;
end