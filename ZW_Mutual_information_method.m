%---------------------Mutual information method---------------------%

%%% Please kindly cite the relevant paper of the author if the codes are helpful to you.
%%% Author contact:
%%% Name: Wang Zhu
%%% Email: wang4027146@foxmail.com; zhuwang@tongji.edu.cn
%%% Orcid: 0000-0003-3844-8014
%%% Researchgate: https://www.researchgate.net/profile/Wang-Zhu-13

clear; clc; close all;

a_all = [2,4,6,8];  %%% four scenarios 
figure;

%% Circulation for the four round tests
for i = 1:4
name = ['TS',num2str(a_all(i)),'.mat'];
load(name)

%%% basic information and input signals
N = size(A,1);   %%% smaple length
fs = 256;        %%% sampling fre
t1 = (1:N)/fs;   %%% interval
x = A(:,34);   %%% input signals

% Parameter setting
maxTau = 200; % max time delay
numBins = 20; % The number of histogram boxes used in probability calculations
mutualInfo = zeros(1, maxTau); % Store mutual information

% calculate mutual information
for tau = 1:maxTau
    % current signal and signal after time delay
    x1 = signal(1:end-tau);
    x2 = signal(tau+1:end);
    
    % marginal probability and joint probability
    [countsX1, ~] = histcounts(x1, numBins, 'Normalization', 'probability');
    [countsX2, ~] = histcounts(x2, numBins, 'Normalization', 'probability');
    [countsJoint, ~, ~] = histcounts2(x1, x2, numBins, 'Normalization', 'probability');
    
    % calculate mutual information
    pX1 = countsX1(countsX1 > 0);
    pX2 = countsX2(countsX2 > 0);
    pJoint = countsJoint(countsJoint > 0);
    
    H1 = -sum(pX1 .* log(pX1)); % H(X)
    H2 = -sum(pX2 .* log(pX2)); % H(Y)
    HJoint = -sum(pJoint .* log(pJoint)); % H(X, Y)
    
    mutualInfo(tau) = H1 + H2 - HJoint;
end

% Find the first local minimum for mutual information
[~, optimalTau] = findpeaks(-mutualInfo);

% drawing

h(i) = plot(1:maxTau, mutualInfo, '-', 'LineWidth', 1.5);
hold on; 
plot(optimalTau(1), mutualInfo(optimalTau(1)), 'r','Marker','o','MarkerSize',10,'LineWidth',2);
hold on


end
xlabel('Time delay (\tau)'); ylabel('Mutual information \itI\rm(\itX\rm, \itY\rm)');
xticks(0:25:200)
set(gca, 'FontName', 'Times New Roman', 'FontSize',16)
set(gcf, 'Color','w')
grid on;
legend([h(1),h(2),h(3),h(4)],{'TS2-X, 0.25g','TS4-X, 0.50g','TS6-X, 1.00g','TS8-X, 1.50g'})