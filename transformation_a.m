
clear registered f_Points fixed fixedPoints m_Points moving movingPoints movingPointsAdjusted mytform

fixed = C1;
moving = C4;
% 
% fixed =filtro(C1);
% moving =filtro(C2);

%      4 To Projective ; 3 To Similarity and affine  
%  f_Points=[37 92;167 39;89 221;219 169];
%  m_Points=[24 88;173 29;85 236;231 175];
 f_Points=[37 92;167 39;89 221];
 m_Points=[24 88;173 29;85 236];
% m_Points=[35 171;220 95];
% f_Points=[47 164;211 98];

% fixedPoints = f_Points;
% movingPoints = m_Points;

cpselect(fixed,moving,f_Points,m_Points);
 movingPointsAdjusted = cpcorr(movingPoints,fixedPoints,moving,fixed);

% figure
% subplot(1,2,1)
% imshow(fixed)
% hold on
% plot(f_Points(:,1),f_Points(:,2),'+b')
% subplot(1,2,2)
% imshow(moving)
% hold on
% plot(movingPointsAdjusted(:,1),movingPointsAdjusted(:,2),'*b')
% plot(m_Points(:,1),m_Points(:,2),'+b')

mytform = fitgeotrans(movingPointsAdjusted, fixedPoints, 'affine');
registered = imwarp(moving, mytform);

figure
imshowpair(fixed,registered,'diff')

