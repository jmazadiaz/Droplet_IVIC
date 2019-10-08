function poss = ventPos ( xmax ,ymax ,width, heigh)
col_ = 10;
row3_ = [0, heigh+95, xmax ];
poss = cell(30,1);
for r_ = 1:3
    for c_ =1:col_
        if c_<= col_/2
        poss (c_+(r_-1)*col_,1) = {[ c_-1+((c_-1)*width),row3_(r_), width ,heigh]};
        else
            poss (c_+(r_-1)*col_,1) = {[ c_-1+((c_-1)*width)+10,row3_(r_), width ,heigh]};
        end
    end
end

end
