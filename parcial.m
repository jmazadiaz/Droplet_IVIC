function p = parcial(f)
    for i_ = 1:length(f)-1
       p(i_) = f(i_+1) - f(i_);
    end
end
