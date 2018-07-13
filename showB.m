
b_centroids_ = [b_cen_(1),b_cen_(2)];
b_radio_ = floor(b_diameters_/2);

b_x=-b_radio_:1:b_radio_;
b_y1=floor(b_centroids_(2))-sqrt((b_radio_.^2)-b_x.^2);
b_y2=floor(b_centroids_(2))+sqrt((b_radio_.^2)-b_x.^2);
b_x= b_centroids_(1)+b_x;

imshow(b_drop_)

hold on
plot(Tcentroids(1),Tcentroids(2), 'b*')
plot(b_centroids_(1),b_centroids_(2),'b*')
plot(b_x,b_y1,b_x,b_y2)
hold off