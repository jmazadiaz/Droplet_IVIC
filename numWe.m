function [We, errWe] = numWe(varDim)

We = (varDim{1}*varDim{3}^2*varDim{5})/varDim{7};

errWe = abs((varDim{3}^2*varDim{5})/varDim{7})*varDim{2}...
      + abs((2*varDim{1}*varDim{3}*varDim{5})/varDim{7})*varDim{4}...
      + abs((varDim{1}*varDim{3}^2)/varDim{7})*varDim{6}...
      + abs((varDim{1}*varDim{3}^2*varDim{5})/varDim{7}^2)*varDim{8};

end