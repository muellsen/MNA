%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Script to analyze microbial association networks presented in
% 
% A single early-in-life macrolide course has lasting effects on murine microbial network topology and immunity
% by Victoria E. Ruiz et al., 2017
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Networks have been learned with SPIEC-EASI with standard settings (Kurtz
% et al, PLOS Comp. Biol, 2015)
%
% Load all five microbial association networks
% in forms of edge lists from VPATNets folder
% Control, PAT1, PAT3, TransControl, TransPAT

cd VPATNets/
load('SENET_Pulse_Control.txt')	
load('SENET_Pulse_PAT1.txt')	
load('SENET_Pulse_PAT3.txt')
load('SENET_Trans_Control.txt')	
load('SENET_Trans_PAT.txt')
cd ../

%% Create adjacency matrix from edge list
pSen_Pulse_Control = max(SENET_Pulse_Control(:));
G_pulse_control = zeros(pSen_Pulse_Control,pSen_Pulse_Control);

for i=1:length(SENET_Pulse_Control)
    G_pulse_control(SENET_Pulse_Control(i,1),SENET_Pulse_Control(i,2)) = 1;
end

pSen_Pulse_Pat1 = max(SENET_Pulse_PAT1(:));
G_pulse_Pat1 = zeros(pSen_Pulse_Pat1,pSen_Pulse_Pat1);

for i =1:length(SENET_Pulse_PAT1)
    G_pulse_Pat1(SENET_Pulse_PAT1(i,1),SENET_Pulse_PAT1(i,2)) = 1;
end

pSen_Pulse_Pat3 = max(SENET_Pulse_PAT3(:));
G_pulse_Pat3 = zeros(pSen_Pulse_Pat3,pSen_Pulse_Pat3);

for i =1:length(SENET_Pulse_PAT3)
    G_pulse_Pat3(SENET_Pulse_PAT3(i,1),SENET_Pulse_PAT3(i,2)) = 1;
end

pSen_Trans_Control = max(SENET_Trans_Control(:));
G_Trans_Control = zeros(pSen_Trans_Control,pSen_Trans_Control);

for i=1:length(SENET_Trans_Control)
    G_Trans_Control(SENET_Trans_Control(i,1),SENET_Trans_Control(i,2)) = 1;
end

pSen_Trans_Pat = max(SENET_Trans_PAT(:));
G_Trans_Pat = zeros(pSen_Trans_Pat,pSen_Trans_Pat);
for i =1:length(SENET_Trans_PAT)
    G_Trans_Pat(SENET_Trans_PAT(i,1),SENET_Trans_PAT(i,2)) = 1;
end


% Store adjancency matrices in cell structure
nGraphs = 5;

G_PAT = cell(nGraphs,1);
G_PAT{1,1} = G_pulse_control+G_pulse_control';
G_PAT{2,1} = G_pulse_Pat1+G_pulse_Pat1';
G_PAT{3,1} = G_pulse_Pat3+G_pulse_Pat3';
G_PAT{4,1} = G_Trans_Control+G_Trans_Control';
G_PAT{5,1} = G_Trans_Pat+G_Trans_Pat';

% Compute a number of graph statistics and store them 
graphStatsPAT = computeGraphStats(G_PAT);

% Extract the largest components of all five graphs and compute their graph
% statistics 
G_PATCC = extractCC(G_PAT);
graphStatsPATCC = computeGraphStats(G_PATCC);

colorID = [1:nGraphs]';

N = max(colorID);
graphStatsPAT.colorID = colorID;
graphStatsPAT.colorName = {'Dose-Control','Dose-PAT1','Dose-PAT3','Trans-Control','Trans-PAT'}';

graphStatsPATCC.colorID = colorID;
graphStatsPATCC.colorName = {'Dose-Control','Dose-PAT1','Dose-PAT3','Trans-Control','Trans-PAT'}';

colorIds = graphStatsPATCC.colorID;
names = graphStatsPATCC.colorName;

colorsQual = colormap(cbrewer('qual', 'Set1', N));
cMatQual = createColorMat(graphStatsPATCC.colorID,colorsQual)

%$ Write adjancency matrices into graphml format with additional features
for i=1:nGraphs
    nodeCell = cell(graphStatsPAT.nNodes(i),3);
   
    nodeCell(:,1) = num2cell(graphStatsPAT.coreG{i});
    tempInt = graphStatsPAT.betweenG{i};
    nodeCell(:,2) = num2cell(tempInt);
    [sortedBTW,sortedInds] = sort(tempInt,'descend');
    tempInt = zeros(graphStatsPAT.nNodes(i),1);
    tempInt(sortedInds(1:2))=1;
    nodeCell(:,3) = num2cell(tempInt);
    
    matToGML(G_PAT{i,1},'fileName',['PATNet_',num2str(i)], 'nodes', nodeCell, 'attrNames', {'coreness','between','top2Between'});
end

for i=1:nGraphs
    matToGML(G_PATCC{i,1},'fileName',['PATNetCC_',num2str(i)]);
end

%% Compute different graph robustness measures
% Original networks
[randRobCell,betweenRobCell,degreeRobCell] = computeRobustness(G_PAT,graphStatsPAT);

% Largest components of the networks
[randRobCellCC,betweenRobCellCC,degreeRobCellCC] = computeRobustness(G_PATCC,graphStatsPATCC);

%% Compute graph comparison measures

% Compute graphlet distributions of all networks
[glcDataPAT,glcDistribPAT] = compGraphlets(G_PAT);

% Compute graphlet distributions of all largest components networks
[glcDataPATCC,glcDistribPATCC] = compGraphlets(G_PATCC);

% Compute graphlet correlation distances (GCD) 
distMat = compGCD(glcDataPAT);

% Compute graphlet correlation distances (GCD)
distMatCC = compGCD(glcDataPATCC);

