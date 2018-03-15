function sub=submatriz(h,i_h,j_h,x,marco)
        
    s_h=zeros(x); 
    add=floor(x/2);
    n=x*x;
    i_=i_h-add; j_= j_h-add; 
    lim=length(h);
    
        for in = 1:x
            
            for jn = 1:x
                if i_<=0
                    s_h(in,jn)= marco;
                    j_ = j_ +1;
                
                elseif i_>=lim
                    s_h(in,jn)= marco;
                    j_ = j_ +1;
                
                elseif j_<=0
                    s_h(in,jn)= marco;
                    j_ = j_ +1;
                
                elseif j_>=lim
                    s_h(in,jn)= marco;
                    j_ = j_ +1;
                
                else    
                    s_h(in,jn)=h(i_,j_);
                    j_ = j_ +1;
                end
                
            end
            j_=j_h-add;
            i_=i_+1;
        end
            sub =s_h;
end