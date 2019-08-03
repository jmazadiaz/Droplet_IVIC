
    a_radio_ = floor(a_diameters_/2);

    a_x_=-a_radio_:1:a_radio_;
    a_y1=floor(a_cen_(2))-sqrt((a_radio_.^2)-a_x_.^2);
    a_y2=floor(a_cen_(2))+sqrt((a_radio_.^2)-a_x_.^2);
    a_x_= a_cen_(1)+a_x_;

    imshow(a_drop_)

    hold on
    plot(Tcentroids(1),Tcentroids(2), 'b*')
    plot(a_cen_(1),a_cen_(2),'b*')
    plot(a_x_,a_y1,a_x_,a_y2)
    hold off
    a_in_=a_in_ + 1;