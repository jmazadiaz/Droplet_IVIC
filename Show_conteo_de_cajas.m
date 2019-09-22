


%% Todas Laminas, Esqueleto y Perimetro Para cada fluido
% Lamina  glicerina
figure
for sh_caso_ =5 :9
BCslope(finger_angle_{sh_caso_,4},1,4,finger_angle_{sh_caso_})
hold on
end
l2 = legend('Gl 48 ','Gl 58','Gl 68','Gl 78','location','best')
title(l2,'Lamina,MaxExpand')
% Esqueleto   glicerina
figure
for sh_caso_ =5 :9
BCslope(finger_angle_{sh_caso_,4},2,4,finger_angle_{sh_caso_})
hold on
end
l2 = legend('Gl 48 ','Gl 58','Gl 68','Gl 78','location','best')
title(l2,'Esqueleto,MaxExpand')
% Perimetro   glicerina
figure
for sh_caso_ =5 :9
BCslope(finger_angle_{sh_caso_,4},3,4,finger_angle_{sh_caso_})
hold on
end
l2 = legend('Gl 48 ','Gl 58','Gl 68','Gl 78','location','best')
title(l2,'Perimetro,MaxExpand')

% Lamina  Agua glicerina
figure
for sh_caso_ =9 :12
BCslope(finger_angle_{sh_caso_,4},1,4,finger_angle_{sh_caso_})
hold on
end
l2 = legend('Ag-Gl 48 ','Ag-Gl 58','Ag-Gl 68','Ag-Gl 78','location','best')
title(l2,'Lamina,MaxExpand')
% Esqueleto  Agua glicerina
figure
for sh_caso_ =9 :12
BCslope(finger_angle_{sh_caso_,4},2,4,finger_angle_{sh_caso_})
hold on
end
l2 = legend('Ag-Gl 48 ','Ag-Gl 58','Ag-Gl 68','Ag-Gl 78','location','best')
title(l2,'Esqueleto,MaxExpand')
% Perimetro  Agua glicerina
figure
for sh_caso_ =9 :12
BCslope(finger_angle_{sh_caso_,4},3,4,finger_angle_{sh_caso_})
hold on
end
l2 = legend('Ag-Gl 48 ','Ag-Gl 58','Ag-Gl 68','Ag-Gl 78','location','best')
title(l2,'Perimetro,MaxExpand')



%%  Misma Altura diferentes Fluidos Para Lamina Esqueleto y Perimetro
%  48 Cm
t(1,1:3)={'Lamina,MaxExpand','Esqueleto,MaxExpand','perimetro,MaxExpand'};

for form = 1:3
figure
BCslope(finger_angle_{1,4},form,4,finger_angle_{1})
hold on 
BCslope(finger_angle_{5,4},form,4,finger_angle_{5})
hold on
BCslope(finger_angle_{9,4},form,4,finger_angle_{9})
l1 = legend('Ag 48 ','Gl 48','Ag-Gl 48','location','best')
title(l1,t{form})
end
% 58 Cm
for form = 1:3
figure
BCslope(finger_angle_{2,4},form,4,finger_angle_{1})
hold on 
BCslope(finger_angle_{6,4},form,4,finger_angle_{5})
hold on
BCslope(finger_angle_{10,4},form,4,finger_angle_{9})
l2 = legend('Ag 58 ','Gl 58','Ag-Gl 58','location','best')
title(l2,t{form})
end
% 68 Cm
for form = 1:3
figure
BCslope(finger_angle_{3,4},form,4,finger_angle_{1})
hold on 
BCslope(finger_angle_{7,4},form,4,finger_angle_{5})
hold on
BCslope(finger_angle_{11,4},form,4,finger_angle_{9})
l3 = legend('Ag 68 ','Gl 68','Ag-Gl 68','location','best')
title(l3,t{form})
end
% 78 Cm
for form = 1:3
figure
BCslope(finger_angle_{4,4},form,4,finger_angle_{1})
hold on 
BCslope(finger_angle_{8,4},form,4,finger_angle_{5})
hold on
BCslope(finger_angle_{12,4},form,4,finger_angle_{9})
l4 = legend('Ag 78 ','Gl 78','Ag-Gl 78','location','best')
title(l4,t{form})
end