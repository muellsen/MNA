function [glcmData,glDistrib] = compGraphlets(Gcell)

% Input:    Gcell: cell array with graphs (i.e. binary adjacency matrices)
%         
% Output:   Graphlet orbit data
%           glcmData: 11 x 11 x number of graphs tensor
%           glDistrib: cell of size number of graphs comprising p_i x 15
%           graphlet counts (p_i: number of nodes in ith graph)


% Number of graphs in input cell
numGraphs = numel(Gcell);

% Graphlet correlation matrix size (GCD-11, Yaveroglu et al, 2014)
gcmSize = 11;

% Initialize tensor structure for storing Graphlet Correlation Matrices
glcmData = zeros(gcmSize,gcmSize,numGraphs);

% Initialize cell structure for graphlet distributions
glDistrib = cell(numGraphs,1);

for i=1:numGraphs
    
    disp(['Graph ',num2str(i),' out of ',num2str(numGraphs)'])
    G = Gcell{i};
    
    % Graphlets (induced subgraphs) of size 4
    glSize = 4;
    
    % Compute graphlet distribution (p_i x 15 matrices where p_i is the number of nodes in the graph i)
    glMat = graphlet(G,glSize);
    
    % Store in cell structure
    glDistrib{i,1} = glMat;

    % Compute graphlet correlation matrix and reorder 
    % the entries according to the order in Yaveroglu et al, 2014 
    [~,glcPerMat,~] = glcm(glMat);
    
    % Store graphlet correlation matrices
    glcmData(:,:,i) = glcPerMat;
    
end


