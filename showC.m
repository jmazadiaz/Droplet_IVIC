    c_centroids_ = [c_cen_(1),c_cen_(2)];
    c_radio_ = floor(c_diameters_/2);

    c_x=-c_radio_:1:c_radio_;
    c_y1=floor(c_centroids_(2))-sqrt((c_radio_.^2)-c_x.^2);
    c_y2=floor(c_centroids_(2))+sqrt((c_radio_.^2)-c_x.^2);
    c_x= c_centroids_(1)+c_x;
    

    imshow(c_drop_)

    hold on
    plot(Tcentroids(1),Tcentroids(2), 'b*')
    plot(c_centroids_(1),c_centroids_(2),'b*')
    plot(c_x,c_y1,c_x,b_y2)
    hold off
   