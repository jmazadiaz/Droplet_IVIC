%%      NO ME FUNCIONO
function frag_img = partimgfrag(part_obj_)

for frag_ = 1: length(part_obj_)
   if frag_ == 1
      frag_img =  part_obj_{frag_};
   
   end
   
       frag_img =  part_obj_{frag_} + frag_img;
    
end

end