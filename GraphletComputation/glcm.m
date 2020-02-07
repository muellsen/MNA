function [glcMat,glcPerMat,permInds] = glcm(glMat)
% Input:   glMat: p x 15 graphlet count matrix (15 graphlets corresponds to glSize=4)
% Output:  glcMat: pxp graphlet correlation matrix
%          glcPerMat: pxp graphlet correlation matrix with permuted order
%          (according to Yaveroglu et al., 2014)
%          permInds: Permutation for plotting correlations according to Yaveroglu et al., 2014   

% Size of the graphlet matrix
[p,nGl] = size(glMat);

% This ensure that only GLD with graphlets of size 4 are used
if nGl~=15
    error('Input must be a px15 matrix')
end

% Ppseudo-count row add if any of the orbits does not exist for any of 
% the nodes (zero column)
if ~all(sum(glMat))
    glMat = [glMat;ones(1,nGl)];
end

% Super set of non-redundant indices (as defined by Yaveroglu et al., 2014)
nonRedInds = [1:12];
currMat = glMat(:,nonRedInds);

% Spearman correlation matrix of 11 non-redundant graphlet orbits
glcMat = corr(currMat,'type','Spearman');
    
% Permutation and selection of 11 non-redundant orbits (Yaveroglu et al.,
% 2014, Figure 2)

permInds = [0 2 5 7 8 10 11 6 9 4 1]+1;
currMat = glMat(:,permInds);

% Spearman correlation of the 11 permuted graphlet distributions
glcPerMat = corr(currMat,'type','Spearman');


