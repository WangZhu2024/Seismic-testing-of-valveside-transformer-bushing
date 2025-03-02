%----------------Phase space reconstruction---------------%

%%% Please kindly cite the relevant paper of the author if the codes are helpful to you.
%%% Author contact:
%%% Name: Wang Zhu
%%% Email: wang4027146@foxmail.com; zhuwang@tongji.edu.cn
%%% Orcid: 0000-0003-3844-8014
%%% Researchgate: https://www.researchgate.net/profile/Wang-Zhu-13

clc;clear;close all;
figure('Position',[200,200,1200,400]);
set(gcf,'Color','w')

a_all = [2,4,6,8];   %%% four scenarios 

%% Circulation for the four round tests
for i =1:4
name = ['TS',num2str(a_all(i)),'.mat'];
load(name)

%%% basic information and input signals
N = size(A,1);   %%% smaple length
fs = 256;        %%% sampling fre
t1 = (1:N)/fs;   %%% interval
x = A(:,34);   %%% input signals

% Phase space reconstruction parameters
tau = 25;  % time delay
m = 3;     % embedding dimension

% Phase space reconstruction
X_reconstruction = ZW_reconstructPhaseSpace(x, tau, m);

% Phase space trajectories 
subplot(2,4,i);
plot3(X_reconstruction(:,1), X_reconstruction(:,2), X_reconstruction(:,3), 'b');
title('Top view');
xlabel('\itx\rm(\itt\rm)');
ylabel('\itx\rm(\itt\rm+\tau)');
zlabel('\itx\rm(\itt\rm+2\tau)');
set(gca,'FontName','Times New Roman','FontSize',10)
grid on;
view(-62.078,-52.6302);
% view(-50.853846317748072,-27.768421761667462);
% a = title('figureaaaa');
% set(a,'Position', [0, -5])

subplot(2,4,i+4);
plot3(X_reconstruction(:,1), X_reconstruction(:,2), X_reconstruction(:,3), 'b');
xlabel('\itx\rm(\itt\rm)');
ylabel('\itx\rm(\itt\rm+\tau)');
zlabel('\itx\rm(\itt\rm+2\tau)');
set(gca,'FontName','Times New Roman','FontSize',10)
grid on;
title('Side view');
% view(-33.048699999999997,42.035055983606341)
view(-31.9263,25.3486)
% view(-33.0487,19.7864)
end

exportgraphics(gcf, 'PhaseSpace.png', 'Resolution', 600);

