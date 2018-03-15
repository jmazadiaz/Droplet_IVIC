function B = move_pt(A,a,b)%mueve, hacia la direccion (a,b), los puntos en una imagen binarias

lim=length(A);
B=zeros(lim);

[I,J] = ind2sub(size(A),find(A==1));
list=vertcat(J',I');

for i_=1:length(list)
    x = list(1,i_);
    y = list(2,i_);
    in_x = x + a;
    in_y = y + b;
    
    if in_x < 0 | in_x > lim | in_y < 0 | in_y > lim
        
        B(y,x)=0;
    
    else    
        
         B(in_y,in_x) = A(y,x);    
    
    end
end