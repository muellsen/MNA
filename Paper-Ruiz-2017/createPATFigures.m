%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script to create Figure 5 (only MDS part) and Suppl. Fig. 5 in
%
% A single early-in-life macrolide course has lasting effects on murine microbial network topology and immunity
% by Victoria E. Ruiz et al., 2017
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Necessary data to plot the results:

% Graph summary statistics
% graphStatsPAT
% graphStatsPATCC

% Graphlet correlation data
% glcDataPAT
% glcDataPATCC

% Attack robustness data
% randRobCell, betweenRobCell,degreeRobCell
% randRobCellCC, betweenRobCellCC,degreeRobCellCC

% If analyzePATNetworks.m is not run before  
% load PATNetworksDataOrig.mat

% Number of networks to analyze
nGraphs = 5;

%% Color scheme used in paper (provided by Zachary Kurtz)
%hexColors = {'000000','2e8f4f','e52b8e','0000ff','ff0000'}
%colorMat = hex2rgb(hexColors)
%colorMat saved in PATNetworksDataOrig.mat

% Graph statistics used here: Full graphs (could also use largest
% component)
graphStats = graphStatsPAT;

%colorMat = cMatQual;
colorIds = graphStats.colorID;
names = graphStats.colorName;

plotInds = [];
for i = 1:max(colorIds)
    plotInds = [plotInds;find(colorIds==i,1)];
end


%% MDS embedding of the five microbial networks

% Compute 2D multidimensional scaling using GCD (stored in distMat)
[mdsCoords,mdstress] = mdscale(distMat,2);

%% Create Figure 5

markersymbol = '...^^';
markersize = {80,80,80,20,20}
scrsz = get(groot,'ScreenSize');
figure('Position',[1 scrsz(4) scrsz(4) scrsz(4)])
for i=1:nGraphs
    k = plotInds(i)
    plot(mdsCoords(i,1),mdsCoords(i,2),markersymbol(i),'MarkerSize',markersize{i},'Color',colorMat(k,:),'MarkerFaceColor',colorMat(k,:))
    grid on
    xlabel('MDS 1')
    hold on
    ylabel('MDS 2')
    box on
end
set(gca,'FontSize',20)
view(-180.01,-90) % To reproduce view from paper
legend(names,'Location','SouthEast','FontSize',20)
saveas(gcf,['Figure5'],'png')
saveas(gcf,['Figure5'],'pdf')


%% Robustness measure
% rInd = 2: Natural connectivity
rInd = 2;

% Scale absolute natural connectivity by asymptotic size 
% to compare networks across different sizes 
% cf. Natural Connectivity of Complex Networks, Wu Jun et al. Chinese Physics Letters, 2010
scaleVec = graphStats.nNodes - log(graphStats.nNodes);


% Axis labels
xTitle = 'Percentage of nodes removed';
yTitle = 'Natural connectivity';
    
%% Create Figure S5

% Plot Betweenness-based removal
scrsz = get(groot,'ScreenSize');
figure('Position',[1 scrsz(4) scrsz(4) scrsz(4)])

for i=1:length(plotInds)
    k=plotInds(i);
    currTrace = betweenRobCellCC{k,rInd}./scaleVec(k);
    plot(linspace(0,1,length(currTrace)),currTrace,'Color',colorMat(k,:),'LineWidth',7)
    grid on
    hold on
    xlabel(xTitle)
    ylabel(yTitle)
    title('a) Betweenness-based removal','FontSize',20)
    if rInd==2
        %ylim([0 0.022])
    end
end

legendhandle1=legend(names(plotInds),'Location','NorthEast');


for i=1:nGraphs
    currTrace = betweenRobCellCC{i,rInd}./scaleVec(i);
    plot(linspace(0,1,length(currTrace)),currTrace,'Color',colorMat(i,:),'LineWidth',7)
end
set(gca,'FontSize',20)
saveas(gcf,['FigureS5a'],'png')
saveas(gcf,['FigureS5a'],'pdf')

% Plot random removal
scrsz = get(groot,'ScreenSize');
figure('Position',[1 scrsz(4) scrsz(4) scrsz(4)])

for i=1:length(plotInds)
    k=plotInds(i);
    currTrace = randRobCellCC{k,rInd}./scaleVec(k);
    plot(linspace(0,1,length(currTrace)),currTrace,'Color',colorMat(k,:),'LineWidth',7)
    grid on
    hold on
    xlabel('Percentage of nodes removed')
    ylabel(yTitle)
    title('b) Random removal','FontSize',20)
    if rInd==2
        %ylim([0 0.022])
    end
end

legendhandle1=legend(names(plotInds),'Location','NorthEast');

for i=1:nGraphs
    currTrace = randRobCellCC{i,rInd}./scaleVec(i);
    plot(linspace(0,1,length(currTrace)),currTrace,'Color',colorMat(i,:),'LineWidth',7)
end
set(gca,'FontSize',20)
saveas(gcf,['FigureS5b'],'png')
saveas(gcf,['FigureS5b'],'pdf')


% Plot Degree-based removal
scrsz = get(groot,'ScreenSize');
figure('Position',[1 scrsz(4) scrsz(4) scrsz(4)])

for i=1:length(plotInds)
    k=plotInds(i);
    currTrace = degreeRobCellCC{k,rInd}./scaleVec(k);
    plot(linspace(0,1,length(currTrace)),currTrace,'Color',colorMat(k,:),'LineWidth',7)
    grid on
    hold on
    xlabel('Percentage of nodes removed')
    ylabel(yTitle)
    title('c) Degree-based removal','FontSize',20)
    if rInd==2
        %ylim([0 0.022])
    end
end

legendhandle1=legend(names(plotInds),'Location','NorthEast');


for i=1:nGraphs
    currTrace = degreeRobCellCC{i,rInd}./scaleVec(i);
    plot(linspace(0,1,length(currTrace)),currTrace,'Color',colorMat(i,:),'LineWidth',7)
end
set(gca,'FontSize',20)
saveas(gcf,['FigureS5c'],'png')
saveas(gcf,['FigureS5c'],'pdf')


%% Keystone analysis 
% Betweenness vs. degree scatter plots (Figure S5e)
for i=1:nGraphs
        
    figure;
    plot(graphStatsPAT.betweenG{i},graphStatsPAT.distribDeg{i},'.','MarkerSize',40)
    grid on
    ylabel('Degree')
    xlabel('Betweenness')
    set(gca,'FontSize',25)
    title([names(i)])
    xlim([0 max(graphStatsPAT.betweenG{i})+100])
    ylim([0 max(graphStatsPAT.distribDeg{i})+1])
    saveas(gcf,['FigureS5e_',num2str(i)],'png')
    saveas(gcf,['FigureS5e_',num2str(i)],'pdf')
    
end














