function glMat = graphlet(G,glSize)
% Input:    G: pxp adjacency matrix (i.e. binary adjacency matrices)
%           glSize: Graphlet size (4 or 5 is allowed), 4 is default
% Output:   glMat: p x o graphlet counts (o: number of graphlets (depends on glSize))

if glSize<4 || glSize>5
    error('Wrong graphlets only enumerable for glNum=4,5')
end

% Specify path to compiled ORCA code here
orcaPath = './orca/orca';

% Specify the temporary output file name
tempFile = 'tempGlMat.mat';

% Transform the adjacency matrix into the input format
% required by the orca package

% Lower triangular matrix without the diagonal
Gl = tril(G,-1);

% Find all non-zero indices
inds = find(Gl);

% Number of edges
e = length(inds);
% Number of nodes
p = size(G,1);

% Node-node indices
[foo,bar]=ind2sub([p,p],inds);

% Shift to start with zero index (orca requires the first node to be the
% zero node)
tempG = [foo-1,bar-1];

% Write graph to text file (as format required by orca)
fileID = fopen('tempG.in','w');
% Write number of nodes and edges in the first line
fprintf(fileID,'%i %i \n',[p e]);
% Write edge list
for i = 1:e
    fprintf(fileID,'%i %i \n',[tempG(i,1) tempG(i,2)]);
end
fclose(fileID);
   
% Call external orca package to compute graphlets
[s,w]=unix([orcaPath,' ',num2str(glSize),' tempG.in ', tempFile]);

% Load orca output file
load(tempFile,'-ASCII')

% Assign graphlet matrix to output 
glMat = tempGlMat;


