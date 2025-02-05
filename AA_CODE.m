%% Defining parameters
clear variables; close all; clc;

% sampling frequency
Fs=500;
flim=[0,35];

%% Identifing the best PSD estimator

patnum = "05";
flag = "1";
filename1 = 'Subject'+ patnum + '_'+ flag +'.mat';

[EEG, ~]=set_data(filename1);
x = EEG(:,1);
psd_estimations(x,Fs, flim);

%% Considering both signals in N=31000 samples

patnum = "05";

% REST
flag = "1";
filename1 = 'Subject'+ patnum + '_'+ flag +'.mat';

[EEG_rest, ~]=set_data(filename1);
EEG_restc = EEG_rest(30001:61000,:); % keeping only the central 62 seconds

% COUNT
flag = "2";
filename1 = 'Subject'+ patnum + '_'+ flag +'.mat';

[EEG_count, ~]=set_data(filename1);

% PSD estimation
K = 6;

[PSD_EEG_rest, freq_r, df_r] = estimPSD(EEG_restc, Fs, K);
[PSD_EEG_count, freq_c, df_c] = estimPSD(EEG_count, Fs, K);

figure;

subplot(2,1,1); hold on;
plot(freq_r(:,1),PSD_EEG_rest(:,1));
plot(freq_r(:,2),PSD_EEG_rest(:,2));
xline(0.5,'r'); xline(4,'r'); xline(8,'r'); xline(12,'r');xline(32,'r');
hold off; grid on; xlabel('Frequency (Hz)'); ylabel('Power/Frequency'); xlim(flim);  
legend(["C3", "C4"]);
title(['REST (df=', num2str(df_r),' ; N= ',num2str(size(EEG_restc,1)),') and K= ',num2str(K)]);

subplot(2,1,2); hold on;
plot(freq_c(:,1),PSD_EEG_count(:,1));
plot(freq_c(:,2),PSD_EEG_count(:,2));
xline(0.5,'r'); xline(4,'r'); xline(8,'r'); xline(12,'r');xline(32,'r');
hold off; grid on; xlabel('Frequency (Hz)'); ylabel('Power/Frequency'); xlim(flim);  
legend(["C3", "C4"]);
title(['COUNT (df=', num2str(df_c),' ; N= ',num2str(size(EEG_count,1)),') and K= ',num2str(K)]);

%% Averaging on different number of windows 

patnum = "05";

% REST
flag = "1";
filename1 = 'Subject'+ patnum + '_'+ flag +'.mat';

[EEG_rest, ~]=set_data(filename1);

% COUNT
flag = "2";
filename1 = 'Subject'+ patnum + '_'+ flag +'.mat';

[EEG_count, dervs]=set_data(filename1);

% PSD estimation
Kr = 18;
Kc = 6;

[PSD_EEG_rest, freq_r, df_r] = estimPSD(EEG_rest, Fs, Kr);
[PSD_EEG_count, freq_c, df_c] = estimPSD(EEG_count, Fs, Kc);

figure;

subplot(2,1,1); hold on;
plot(freq_r(:,1),PSD_EEG_rest(:,1));
plot(freq_r(:,2),PSD_EEG_rest(:,2));
xline(0.5,'r'); xline(4,'r'); xline(8,'r'); xline(12,'r');xline(32,'r');
hold off; grid on; xlabel('Frequency (Hz)'); ylabel('Power/Frequency'); xlim(flim);  
legend(["C3", "C4"]);
title(['REST (df=', num2str(df_r),' ; N= ',num2str(size(EEG_rest,1)),') and K= ',num2str(Kr)]);

subplot(2,1,2); hold on;
plot(freq_c(:,1),PSD_EEG_count(:,1));
plot(freq_c(:,2),PSD_EEG_count(:,2));
xline(0.5,'r'); xline(4,'r'); xline(8,'r'); xline(12,'r');xline(32,'r');
hold off; grid on; xlabel('Frequency (Hz)'); ylabel('Power/Frequency'); xlim(flim);  
legend(["C3", "C4"]);
title(['COUNT (df=', num2str(df_c),' ; N= ',num2str(size(EEG_count,1)),') and K= ',num2str(Kc)]);


%% Signal processing and analysis
clear variables; close all; clc;

% sampling frequency
Fs=500;
flim=[0,35];

for patnum = ["01","02","03","05","07","08"]

    % REST
    flag = "1";
    filename = 'Subject'+ patnum + '_'+ flag +'.mat';
    
    [EEG_rest, ~]=set_data(filename);
    EEG_restc = EEG_rest(30001:61000,:); % keeping only the central 62 seconds
    
    % COUNT
    flag = "2";
    filename = 'Subject'+ patnum + '_'+ flag +'.mat';
    
    [EEG_count, dervs]=set_data(filename);
    
    % PSD estimation
    K = 6;
    
    [PSD_EEG_rest, freq_r, df_r] = estimPSD(EEG_restc, Fs, K);
    [PSD_EEG_count, freq_c, df_c] = estimPSD(EEG_count, Fs, K);

    gPSD(patnum, EEG_restc, PSD_EEG_rest, freq_r, df_r, EEG_count, PSD_EEG_count, freq_c, df_c, flim);
   
end 

%% compute the amount of energy in frequency bands of interest
clear variables; close all; clc;

% sampling frequency
fs=500;
flim=[0,35];

% brainwaves reference bands
Delta = [0.5,4];
Theta = [4,8];
Theta1 = [4,5.99];
Theta2 = [6,8];
Alpha = [8,12];
Beta = [12,32];
Beta_SMR = [12,14.99];
Beta_MidB = [15,19.99];
Beta_high = [20,32];
Gamma = [32,fs];


all_patnum = ["01","02","03","05","07","08"];
subs = ["S01","S02","S03","S05","S07","S08"];
range = [0,24];

for i=1:length(all_patnum)

    patnum=all_patnum(i);

    % REST
    flag = "1";
    filename = 'Subject'+ patnum + '_'+ flag +'.mat';
    
    [EEG_rest, ~]=set_data(filename);
    EEG_restc = EEG_rest(30001:61000,:); % keeping only the central 62 seconds
    
    % COUNT
    flag = "2";
    filename = 'Subject'+ patnum + '_'+ flag +'.mat';
    
    [EEG_count, dervs]=set_data(filename);
    
    % PSD estimation
    K = 6;
    
    [PSD_EEG_rest, freq_r, df_r] = estimPSD(EEG_restc, fs, K);
    [PSD_EEG_count, freq_c, df_c] = estimPSD(EEG_count, fs, K);

    
    [perc_rest_a, avgpwband_rest_a, avgpw_rest_a] = avgpw(PSD_EEG_rest, freq_r(:,1), Alpha);
    [perc_rest_t, avgpwband_rest_t, avgpw_rest_t] = avgpw(PSD_EEG_rest, freq_r(:,1), Theta);
    [perc_rest_t1, avgpwband_rest_t1, avgpw_rest_t1] = avgpw(PSD_EEG_rest, freq_r(:,1), Theta1);
    [perc_rest_t2, avgpwband_rest_t2, avgpw_rest_t2] = avgpw(PSD_EEG_rest, freq_r(:,1), Theta2);
    [perc_rest_b, avgpwband_rest_b, avgpw_rest_b] = avgpw(PSD_EEG_rest, freq_r(:,1), Beta);
    [perc_rest_b1, avgpwband_rest_b1, avgpw_rest_b1] = avgpw(PSD_EEG_rest, freq_r(:,1), Beta_SMR);
    [perc_rest_b2, avgpwband_rest_b2, avgpw_rest_b2] = avgpw(PSD_EEG_rest, freq_r(:,1), Beta_MidB);

    [perc_count_a, avgpwband_count_a, avgpw_count_a] = avgpw(PSD_EEG_count, freq_r(:,1), Alpha);
    [perc_count_t, avgpwband_count_t, avgpw_count_t] = avgpw(PSD_EEG_count, freq_r(:,1), Theta);
    [perc_count_t1, avgpwband_count_t1, avgpw_count_t1] = avgpw(PSD_EEG_count, freq_c(:,1), Theta1);
    [perc_count_t2, avgpwband_count_t2, avgpw_count_t2] = avgpw(PSD_EEG_count, freq_c(:,1), Theta2);
    [perc_count_b, avgpwband_count_b, avgpw_count_b] = avgpw(PSD_EEG_count, freq_r(:,1), Beta);
    [perc_count_b1, avgpwband_count_b1, avgpw_count_b1] = avgpw(PSD_EEG_count, freq_c(:,1), Beta_SMR);
    [perc_count_b2, avgpwband_count_b2, avgpw_count_b2] = avgpw(PSD_EEG_count, freq_c(:,1), Beta_MidB);
    
    Theta_Beta_r(i,:) = avgpwband_rest_t./avgpwband_rest_b;
    SMRMidB_Theta_r(i,:) = (avgpwband_rest_b1+avgpwband_rest_b2)./avgpwband_rest_t;
    Theta_Alpha_r(i,:) = avgpwband_rest_t./avgpwband_rest_a;
    Theta_Beta_c(i,:) = avgpwband_count_t./avgpwband_count_b;
    SMRMidB_Theta_c(i,:) = (avgpwband_count_b1+avgpwband_count_b2)./avgpwband_count_t;
    Theta_Alpha_c(i,:) = avgpwband_count_t./avgpwband_count_a;

    A_all_rest(i,:) = perc_rest_a;
    T_all_rest(i,:) = perc_rest_t;
    T1_all_rest(i,:) = perc_rest_t1;
    T2_all_rest(i,:) = perc_rest_t2;
    B_all_rest(i,:) = perc_rest_b;
    B1_all_rest(i,:) = perc_rest_b1;
    B2_all_rest(i,:) = perc_rest_b2;

    A_all_count(i,:) = perc_count_a;
    T_all_count(i,:) = perc_count_t;
    T1_all_count(i,:) = perc_count_t1;
    T2_all_count(i,:) = perc_count_t2;
    B_all_count(i,:) = perc_count_b;
    B1_all_count(i,:) = perc_count_b1;
    B2_all_count(i,:) = perc_count_b2;

    A_all_rest_av(i,:) = avgpwband_rest_a;
    T_all_rest_av(i,:) = avgpwband_rest_t;
    T1_all_rest_av(i,:) = avgpwband_rest_t1;
    T2_all_rest_av(i,:) = avgpwband_rest_t2;
    B_all_rest_av(i,:) = avgpwband_rest_b;
    B1_all_rest_av(i,:) = avgpwband_rest_b1;
    B2_all_rest_av(i,:) = avgpwband_rest_b2;

    A_all_count_av(i,:) = avgpwband_count_a;
    T_all_count_av(i,:) = avgpwband_count_t;
    T1_all_count_av(i,:) = avgpwband_count_t1;
    T2_all_count_av(i,:) = avgpwband_count_t2;
    B_all_count_av(i,:) = avgpwband_count_b;
    B1_all_count_av(i,:) = avgpwband_count_b1;
    B2_all_count_av(i,:) = avgpwband_count_b2;
    
end 

%% plot histograms ALPHA, THETA, BETA 

% all obtained matrices have 
% 6 rows (i-th row is the i-th patient in subs = ["S01","S02","S03","S05","S07","S08"])
% 19 columns (j-th column is the j-th derivation in dervs = ["C3", "C4","CZ", "F3" , "F4", 
%                                                            "F7", "F8", "FP1", "FP2","FZ",
%                                                            "O1","O2","P3","P4","PZ","T3","T4","T5","T6"])

% subjects = ["S01","S02","S03","S05","S07","S08"];
% 
% for i=1:length(subjects)
% 
%      figure('Name', subs(i) ,'NumberTitle','off');
% 
%      subplot(3,1,1); hold on; bar(1:19, [A_all_rest(i,:); A_all_count(i,:)]); hold off;
%      title('Alpha'); xlabel('Derivations'); ylabel('Norm. Pow.'); xticks(1:19); legend(["REST","COUNT"]);
%      subplot(3,1,2); hold on; bar(1:19, [B_all_rest(i,:); B_all_count(i,:)]); hold off;
%      title('Beta'); xlabel('Derivations'); ylabel('Norm. Pow.'); xticks(1:19); legend(["REST","COUNT"]);
%      subplot(3,1,3); hold on; bar(1:19, [T_all_rest(i,:); T_all_count(i,:)]); hold off;
%      title('Theta'); xlabel('Derivations'); ylabel('Norm. Pow.'); xticks(1:19); legend(["REST","COUNT"]);
% 
% end 

figure('Name', "Total Trend" ,'NumberTitle','off');

subplot(3,2,1); boxplot(A_all_rest); title('Alpha - REST');
subplot(3,2,2); boxplot(A_all_count); title('Alpha - COUNT');
subplot(3,2,3); boxplot(B_all_rest); title('Beta - REST');
subplot(3,2,4); boxplot(B_all_count); title('Beta - COUNT');
subplot(3,2,5); boxplot(T_all_rest); title('Theta - REST');
subplot(3,2,6); boxplot(T_all_count); title('Theta - COUNT');

A_all_avg_av = [ mean(A_all_rest_av); mean(A_all_count_av)];
B_all_avg_av = [ mean(B_all_rest_av); mean(B_all_count_av)];
T_all_avg_av = [ mean(T_all_rest_av); mean(T_all_count_av)];

figure('Name', "Average Trend (Absolute Values)" ,'NumberTitle','off');

subplot(3,1,1); hold on; bar(1:19, A_all_avg_av); hold off;
title('Alpha');  ylabel('Power'); xticks(1:19); legend(["REST","COUNT"]);
xticklabels(dervs);
subplot(3,1,2); hold on; bar(1:19, B_all_avg_av); hold off;
title('Beta'); ylabel('Power'); xticks(1:19); legend(["REST","COUNT"]);
xticklabels(dervs);
subplot(3,1,3); hold on; bar(1:19, T_all_avg_av); hold off;
title('Theta'); xlabel('Derivations'); ylabel('Power'); xticks(1:19); legend(["REST","COUNT"]);
xticklabels(dervs);

REST_avg = [ mean(A_all_rest); mean(B_all_rest); mean(T_all_rest)];
COUNT_avg = [ mean(A_all_count); mean(B_all_count); mean(T_all_count)];

figure('Name', "Average Trend" ,'NumberTitle','off');

subplot(2,1,1); hold on; bar(1:19, REST_avg); hold off;
title('REST');  ylabel('Norm. Pow.'); xticks(1:19); legend(["Alpha","Beta", "Tetha"]);
xticklabels(dervs);
subplot(2,1,2); hold on; bar(1:19, COUNT_avg); hold off;
title('COUNT'); ylabel('Norm. Pow.'); xticks(1:19); legend(["Alpha","Beta", "Tetha"]);
xticklabels(dervs);

%%  Indices:   Theta/Beta, SMR+MidB/Theta, Theta/Alpha

figure;  

subplot(3,1,1); bar(1:19, (mean(Theta_Beta_c) - mean(Theta_Beta_r))); title('Theta/Beta (Count - Rest)'); xticks(1:19); xticklabels(dervs);
subplot(3,1,2); bar(1:19, (mean(SMRMidB_Theta_c) - mean(SMRMidB_Theta_r))); title('SMR+MidB/Theta (Count - Rest)'); xticks(1:19); xticklabels(dervs);
subplot(3,1,3); bar(1:19, (mean(Theta_Alpha_c) - mean(Theta_Alpha_r))); title('Theta/Alpha (Count - Rest)'); xticks(1:19); xticklabels(dervs);
xlabel('Derivations'); 

figure('Name', "Total Trend" ,'NumberTitle','off');

subplot(3,2,1); boxplot(Theta_Beta_r); title('Theta/Beta - REST');
subplot(3,2,2); boxplot(Theta_Beta_c); title('Theta/Beta - COUNT');
subplot(3,2,3); boxplot(SMRMidB_Theta_r); title('SMR+MidB/Theta - REST');
subplot(3,2,4); boxplot(SMRMidB_Theta_c); title('SMR+MidB/Theta - COUNT');
subplot(3,2,5); boxplot(Theta_Alpha_r); title('Theta/Alpha - REST');
subplot(3,2,6); boxplot(Theta_Alpha_c); title('Theta/Alpha - COUNT');

%% Topoplots
load chanlocs.mat;

figure; 
subplot(3,2,1); topoplot(mean(Theta_Beta_r), chanlocs, 'maplimits' , [min(mean(Theta_Beta_c)) max(mean(Theta_Beta_c))]); title('Theta/Beta - REST');
subplot(3,2,2); topoplot(mean(Theta_Beta_c), chanlocs, 'maplimits' , [min(mean(Theta_Beta_c)) max(mean(Theta_Beta_c))]); title('Theta/Beta - COUNT');
subplot(3,2,3); topoplot(mean(SMRMidB_Theta_r), chanlocs, 'maplimits' , [min(mean(SMRMidB_Theta_c)) max(mean(SMRMidB_Theta_c))]); title('SMR+MidB/Theta - REST');
subplot(3,2,4); topoplot(mean(SMRMidB_Theta_c), chanlocs, 'maplimits' , [min(mean(SMRMidB_Theta_c)) max(mean(SMRMidB_Theta_c))]); title('SMR+MidB/Theta - COUNT');
subplot(3,2,5); topoplot(mean(Theta_Alpha_r), chanlocs, 'maplimits' , [min(mean(Theta_Alpha_r)) max(mean(Theta_Alpha_c))]); title('Theta/Alpha - REST');
subplot(3,2,6); topoplot(mean(Theta_Alpha_c), chanlocs, 'maplimits' , [min(mean(Theta_Alpha_r)) max(mean(Theta_Alpha_c))]); title('Theta/Alpha - COUNT');
