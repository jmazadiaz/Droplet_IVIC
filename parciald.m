function p2 = partiald(f)
    for i_ = 2:length(f)-1
        p2(i_) = f(i_+1)+f(i_-1)-(2*f(i_));
end