function distMat = compGCD(glcData)
% Input:    glcData: 11 x 11 x number of graphs tensor for graphlet
%           correlation (GC) matrices 
%         
% Output:   distMat: nNets x nNets matrix of Frobenius distances between GC
%           matrices

% Deterrmine size of graphlet correlation matrix (nxn)
% and number of networks (nNets)
[n,~,nNets] = size(glcData);

% Initialize distance matrix
distMat = zeros(nNets,nNets);

% Compute Frobenius norm between 
for t=1:nNets
    % Current vectorized reference GC matrix
    refMat = squeeze(glcData(:,:,t));
    
    for t1=1:nNets
        % Current vectorized GC matrix
        currMat = squeeze(glcData(:,:,t1));
        distMat(t,t1) = sqrt(sum((refMat(:)-currMat(:)).^2)/2);
    end
    
end