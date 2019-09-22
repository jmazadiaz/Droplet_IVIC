

close all
clear


parte_ = '/home/maza/AllMeida/Dropbox/Droplets/Matlab/Droplets/partes/New_Folder/partes_AGL78.mat';
title_histogram_48_ = strcat('Distribución de tamaños',frag_size_{1});
title_histogram_58_ = strcat('Distribución de tamaños',frag_size_{2});
title_histogram_68_ = strcat('Distribución de tamaños',frag_size_{3});

load(parte_)
 
img_ = zeros(256,256);

for ind_vid_ = 1: length(Partes)
   px_list_all_ = vertcat(Partes{ind_vid_,4}.PixelIdxList)
   bw_figure_all_(:,:,ind_vid_) = object(img_ ,px_list_all_);
    clear px_list_all_
end

histogram(j
j48_ = vertcat(frag_size_{1, 3}.Area_Fragmentos(:));
j58_ = vertcat(frag_size_{2, 3}.Area_Fragmentos(:));
j68_ = vertcat(frag_size_{3, 3}.Area_Fragmentos(:));

j48_ (j48_==0)= [];   pd48_ = fitdist(j48_,'Gamma');
j58_ (j58_==0)= [];   pd58_ = fitdist(j58_,'Gamma');
j68_ (j68_==0)= [];   pd68_ = fitdist(j68_,'Gamma');



y58_ = pdf(pd58_,x_values);
y68_ = pdf(pd68_,x_values);





%%      Show 

figure1 = figure('Name',strcat('Img. frag.todos : ',frag_size_{1}),...
                 'NumberTitle','off');

imshow(...
[bw_figure_all_(:,:,1)  bw_figure_all_(:,:,2)  bw_figure_all_(:,:,3)  bw_figure_all_(:,:,4)  bw_figure_all_(:,:,5) ...
 bw_figure_all_(:,:,6)  bw_figure_all_(:,:,7)  bw_figure_all_(:,:,8)  bw_figure_all_(:,:,9) bw_figure_all_(:,:,10);...
bw_figure_all_(:,:,11) bw_figure_all_(:,:,12) bw_figure_all_(:,:,13) bw_figure_all_(:,:,14) bw_figure_all_(:,:,15)...
bw_figure_all_(:,:,16) bw_figure_all_(:,:,17) bw_figure_all_(:,:,18) bw_figure_all_(:,:,19) bw_figure_all_(:,:,20);...
bw_figure_all_(:,:,21) bw_figure_all_(:,:,22) bw_figure_all_(:,:,23) bw_figure_all_(:,:,24) bw_figure_all_(:,:,25)...
bw_figure_all_(:,:,26) bw_figure_all_(:,:,27) bw_figure_all_(:,:,28) bw_figure_all_(:,:,29) bw_figure_all_(:,:,30)]);


%                   HISTOGRAMA
figure1 = figure('Name',strcat('Dist. tamaños : ',frag_size_{1}),...
                 'NumberTitle','off');                                                % Create figure

axes1 = axes('Parent',figure1);                                                 % Create axes
hold(axes1,'on');

histogram(j1','BinWidth',2,'Normalization','pdf')

% Create ylabel
ylabel('Frecuencia');

% Create xlabel
xlabel('tamaño de fragmento');

% Create title
title(title_histogram_48_);
hold on
plot(x_values,y48_,'LineWidth',2)




