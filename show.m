c(:,1) = vertcat(c_d_(:,1), c_d_(:,4), c_d_(:,7), c_d_(:,10), c_d_(:,13), c_d_(:,16), c_d_(:,19), c_d_(:,22));
c(:,2) = vertcat(c_d_(:,2), c_d_(:,5), c_d_(:,8), c_d_(:,11), c_d_(:,14), c_d_(:,17), c_d_(:,20), c_d_(:,23));
c(:,3) = vertcat(c_d_(:,3), c_d_(:,6), c_d_(:,9), c_d_(:,12), c_d_(:,15), c_d_(:,18), c_d_(:,21), c_d_(:,24));
bar3(c)

% subplot(3,3,1)
% imshow(I1_)
% subplot(3,3,2)
% plot(temIph1_)
% subplot(3,3,3)
% plot(temIIph1_)
% subplot(3,3,4)
% imshow(I2_)
% subplot(3,3,5)
% plot(temIph2_)
% subplot(3,3,6)
% plot(temIIph2_)
% subplot(3,3,7)
% imshow(I3_)
% subplot(3,3,8)
% plot(temIph3_)
% subplot(3,3,9)
% plot(temIIph3_)