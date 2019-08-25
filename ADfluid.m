%% ADfluid.m Diametro = 3.1537e-04

function [We , Re ]=ADfluid(densidad, velocidad, diametro , tsuper , visco)

    for i_ = 1:length(velocidad)
        We(i_) = (densidad*diametro/tsuper) * velocidad(i_)^2;
    end
    
    for i_ = 1:length(velocidad)
        Re(i_) = (densidad*diametro/visco)*velocidad(i_);
    end
    
end