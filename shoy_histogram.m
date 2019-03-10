bins_ = 12
caso_ = 12

figure


% for ind_hist_ = 1:30
%     
% subplot(5,6,ind_hist_) 
% histogram(frag_size_{caso_, 3}.Area_Fragmentos(ind_hist_,:),bins_,'DisplayStyle','bar',...
%          'Normalization','probability','EdgeColor','auto','facecolor','m',...
%          'facealpha',.8,'edgecolor','none' );
%    
% end

histogram(frag_size_{caso_, 3}.Area_Fragmentos(1:end,:),bins_,'DisplayStyle','bar',...
         'Normalization','probability','EdgeColor','auto','facecolor','m',...
         'facealpha',.8,'edgecolor','none' );