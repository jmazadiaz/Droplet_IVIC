
se_ = strel('disk',1);
i2_dilate_ = imdilate(ibw_,se_);

 moda_ = mode(i2_(p_target_),2);
    max_ = max(max(i2_(target_)));
    min_ = min(min(i2_(target_)));
    med_ = mode(moda_);
 
subplot(2,2,1)
imshow(i2_)
subplot(2,2,2)
imshow(i2_open_)
subplot(2,2,3)
imshow(i2_close_)
subplot(2,2,4)
imshow(i2_dilate_)