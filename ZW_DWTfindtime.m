%--------------------Discrete wavelet transform--------------------%

%%% Please kindly cite the relevant paper of the author if the codes are helpful to you.
%%% Author contact:
%%% Name: Wang Zhu
%%% Email: wang4027146@foxmail.com; zhuwang@tongji.edu.cn
%%% Orcid: 0000-0003-3844-8014
%%% Researchgate: https://www.researchgate.net/profile/Wang-Zhu-13

clear; clc; close all;

%% input the original data
load('TS8.mat')

%% Input basic information and signals collected
signal = A(:,34);   %%% collected acceleration data
signal = signal - mean(signal(1:1000,1));    %%% remove the offset
signal = signal(2500:50*256+2500,1);         %%% remove long zero values at the beginning and end
fs = 256;     %%% sampling fre
N = size(signal,1);   %%% sampling length
t = (1:N)/fs;         %%% interval

%% Wavelet transform parameter
waveletType = 'db4';   %%% Daubechies 4 wavelet
maxLevel = 12;         %%% maximum decomposition level
    % Adaptive maximum decomposable order
decomporder = min(maxLevel, wmaxlev(length(signal), waveletType)); 

%% Wavelet decomposition
[C, L] = wavedec(signal, decomporder, waveletType);

%%% Denoising: Soft-threshold denoising of the detail coefficient
threshold = sqrt(2*log(length(signal))); % threshold
for i = 1:decomporder
    %%% Thresholding of the ith order of detail coefficient
    C = wthcoef('d', C, L, i, threshold);
end

%% Wavelet reconsurction
approximation = appcoef(C, L, waveletType, decomporder);  %%% the highest-level approximate coefficient
d1_reconstructed = wrcoef('d', C, L, waveletType, 1);     %%% the first level of detail coefficient

%% drawing
figure('Position',[400,200,800,300])
set(gcf, 'Color','w')
plot(t, d1_reconstructed);
grid on
xlim([0,50])
ylim([-12,13])
xlabel('Time (s)'); ylabel('\itD\rm_1');
set(gca,'FontName','Times New Roman','FontSize',16)
set(gca,'XMinorGrid','on')
set(gca,'YMinorGrid','on')

