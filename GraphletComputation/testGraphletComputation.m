% Part of the MNA package - Graphlet correlation distances between networks

% Script that shows how to compute graphlets and graphlet correlation
% distances for a set of networks; the examples are  taken from the PAT
% study (Ruiz et al., 2017)

load('../Paper-Ruiz-2017/PATNetworksDataOrig.mat')

% Use the cell G_PAT comprising five microbial networks from the PAT study

G_PAT

% G_PAT =
% 
%   5×1 cell array
% 
%     { 83×83  double}
%     {139×139 double}
%     {191×191 double}
%     {383×383 double}
%     {507×507 double}

nGraphs = length(G_PAT);

% Compute graphlet distributions and graphlet correlation matrices
[glcmDataEx,glDistribEx] = compGraphlets(G_PAT);

% Order of permuted indices according to Yaveroglu et al. 
permInds = [0 2 5 7 8 10 11 6 9 4 1];

% Show Graphlet Correlation matrices
for i=1:nGraphs
    figure(i)
    imagesc(glcmDataEx(:,:,i));
    set(gca, 'XTickLabel',permInds)
    set(gca, 'YTickLabel',permInds)
    colorbar
    title(['GCM of Network ',num2str(i)],'FontSize',20)
end

% Compute graphlet correlation distance matrix
distMatEx = compGCD(glcmDataEx)

% Compute MDS embedding of the networks based on GC distances
mdCoords = mdscale(distMatEx, 2);

% Plot MDS embedding of the networks
figure;
plot(mdCoords(1,1),mdCoords(1,2),'.','MarkerSize',100)
hold on
plot(mdCoords(2,1),mdCoords(2,2),'.','MarkerSize',100)
plot(mdCoords(3,1),mdCoords(3,2),'.','MarkerSize',100)
plot(mdCoords(4,1),mdCoords(4,2),'.','MarkerSize',100)
plot(mdCoords(5,1),mdCoords(5,2),'.','MarkerSize',100)
grid on
xlabel('MDS 1')
ylabel('MDS 2')
axis equal
legend({'Network 1','Network 2','Network 3','Network 4','Network 5'},'FontSize',20)

% Remove temporary text files
!rm tempG.in
!rm tempGlMat.mat

% Test correctness of the computation by comparing distance calculations
% with the ones provided in the PATNetworksDataOrig.mat file

% Pre-computed distance matrix distMat

distDiff = norm(distMat(:)-distMatEx(:));
display(['L2 norm difference between pre-computed and computed distance matrix: ',num2str(distDiff)])













