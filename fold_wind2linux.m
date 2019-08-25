%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Convertir dirección win to linux
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear

sf_drop_ = ['48';'58';'68';'78']; 

folder_drop_a_ = '/home/maza/AllMeida/Droplets_Video/0AG/';
folder_drop_b_ = '/home/maza/AllMeida/Droplets_Video/AGL/';
folder_drop_c_ = '/home/maza/AllMeida/Droplets_Video/0GL/';


forder_save_ = '/home/maza/AllMeida/Dropbox/Droplets/Matlab/Droplets/folders/'; % Carpeta de calibracion%
exten_save_ = '.mat';

filetype_drops_ = 'jpg';    

sustanci_a_ = '0AG';    sustanci_b_ = 'AGL';    sustanci_c_ = '0GL';

%%              Agua

for h_ = 1:4 

file_fold =strcat(forder_save_,'folder-',sustanci_a_,sf_drop_(h_,:),...      % Direccion del parametro de correción
                        exten_save_);
fold = dir(strcat(folder_drop_a_,sf_drop_(h_,:),'/AVI/IMG/'));

    for i_ = 1:length(fold)-2
        folders_{i_} = strcat(fold(i_+2).folder,'/', fold(i_+2).name);
    end
save(file_fold, 'folders_');
clear folders_

end

%%      Agua Glicerina

for h_ = 1:4 

file_fold =strcat(forder_save_,'folder-',sustanci_b_,sf_drop_(h_,:),...      % Direccion del parametro de correción
                        exten_save_);
fold = dir(strcat(folder_drop_b_,sf_drop_(h_,:),'/AVI/IMG/'));

    for i_ = 1:length(fold)-2
        folders_{i_} = strcat(fold(i_+2).folder,'/', fold(i_+2).name);
    end
save(file_fold, 'folders_');
clear folders_
    
end

%%      Glicerina

for h_ = 1:4 

file_fold =strcat(forder_save_,'folder-',sustanci_c_,sf_drop_(h_,:),...      % Direccion del parametro de correción
                        exten_save_);
fold = dir(strcat(folder_drop_c_,sf_drop_(h_,:),'/AVI/IMG/'));

    for i_ = 1:length(fold)-2
        folders_{i_} = strcat(fold(i_+2).folder,'/', fold(i_+2).name);
    end
save(file_fold, 'folders_');
clear folders_

end