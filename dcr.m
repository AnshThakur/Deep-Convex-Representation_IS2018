clc;
clear;

%% generate random data
 [x,y] = rand_circ(4000,4,4,1);
points=[x y];


%% archetypal analysis parameters
param.p=15;
param.robust=false;
param.epsilon=10^-3;  % width for Huber loss
param.computeXtX=true;
param.stepsFISTA=0;
param.stepsAS=10;
param.numThreads=-1;

%% level 1 decomposition
[D1 A1 B] = mexArchetypalAnalysis(points',param);
A1=full(A1);
%% level 2 decomposition 
[D2 A2 B] = mexArchetypalAnalysis(A1,param);
A2=full(A2);

%% level 3 decomposition 
[D3 A3 B] = mexArchetypalAnalysis(A2,param);
A3=full(A3);

%% get final dictionary
D_2=D1*D2;
D_f=D1*D2*D3;

%% visualization of archetypes
scatter(points(:,1),points(:,2),20,'b.');
hold on; 
D_2=D_2';
Dict=D_f';
D_1=D1';
hold on;scatter(D_1(:,1),D_1(:,2),60,'ko','filled')
hold on;scatter(D_2(:,1),D_2(:,2),50,'rd','filled')
hold on;scatter(Dict(:,1),Dict(:,2),45,'g^','filled')
legend('data points','level 1 archetypes','level 2 archetypes','level 3 arcetypes')

%% final dictionary D_f can be used to obtain deep convex representations

% generate data
[x,y] = rand_circ(10,4,4,1);
test=[x y];

%% simplex decomposition
DCR=mexDecompSimplex(test',D_f,param);
DCR=full(DCR);
DCR=DCR';
%% ploting one DCR
figure; plot(DCR(1,:)); legend('Deep convex representation');







