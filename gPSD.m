
function gPSD(patnum, EEG1, PSD_EEG1, freq1, df1, EEG2, PSD_EEG2, freq2, df2, flim)
    
    % dervs = ["C3", "C4", "CZ", "F3" , "F4", "F7", "F8", "FP1", "FP2","FZ","O1","O2","P3","P4","PZ","T3","T4","T5","T6"];
    
    figure('Name','Subject '+ patnum ,'NumberTitle','off');

    subplot(5,2,1); hold on;
    plot(freq1(:,1),PSD_EEG1(:,1));
    plot(freq1(:,2),PSD_EEG1(:,2));
    plot(freq1(:,3),PSD_EEG1(:,3));
     xline(0.5,'r'); xline(4,'r'); xline(8,'r'); xline(12,'r');xline(32,'r');
    hold off; grid on; xlabel('Frequency (Hz)'); ylabel('Power/Frequency'); xlim(flim); 
    legend(["C3", "C4", "CZ"]); title(['REST (df=', num2str(df1),' ; N= ',num2str(size(EEG1,1)),')']);

    subplot(5,2,2); hold on;
    plot(freq2(:,1),PSD_EEG2(:,1));
    plot(freq2(:,2),PSD_EEG2(:,2));
    plot(freq2(:,3),PSD_EEG2(:,3));
    xline(0.5,'r'); xline(4,'r'); xline(8,'r'); xline(12,'r');xline(32,'r');
    hold off; grid on; xlabel('Frequency (Hz)'); ylabel('Power/Frequency'); xlim(flim); 
    legend(["C3", "C4", "CZ"]); title(['COUNTING (df=',num2str(df2),' ; N= ',num2str(size(EEG2,1)),')']);

    subplot(5,2,3); hold on;
    plot(freq1(:,4),PSD_EEG1(:,4));
    plot(freq1(:,5),PSD_EEG1(:,5));
    plot(freq1(:,6),PSD_EEG1(:,6));
    plot(freq1(:,7),PSD_EEG1(:,7));
    plot(freq1(:,8),PSD_EEG1(:,8));
    plot(freq1(:,9),PSD_EEG1(:,9));
    plot(freq1(:,10),PSD_EEG1(:,10));
    xline(0.5,'r'); xline(4,'r'); xline(8,'r'); xline(12,'r');xline(32,'r');
    hold off; grid on; xlabel('Frequency (Hz)'); ylabel('Power/Frequency'); xlim(flim); 
    legend(["F3" , "F4", "F7", "F8", "FP1", "FP2","FZ"]); 

    subplot(5,2,4); hold on;
    plot(freq2(:,4),PSD_EEG2(:,4));
    plot(freq2(:,5),PSD_EEG2(:,5));
    plot(freq2(:,6),PSD_EEG2(:,6));
    plot(freq2(:,7),PSD_EEG2(:,7));
    plot(freq2(:,8),PSD_EEG2(:,8));
    plot(freq2(:,9),PSD_EEG2(:,9));
    plot(freq2(:,10),PSD_EEG2(:,10));
    xline(0.5,'r'); xline(4,'r'); xline(8,'r'); xline(12,'r');xline(32,'r');
    hold off; grid on; xlabel('Frequency (Hz)'); ylabel('Power/Frequency'); xlim(flim); 
    legend(["F3" , "F4", "F7", "F8", "FP1", "FP2","FZ"]); 
    
    subplot(5,2,5); hold on;
    plot(freq1(:,11),PSD_EEG1(:,11));
    plot(freq1(:,12),PSD_EEG1(:,12));
    xline(0.5,'r'); xline(4,'r'); xline(8,'r'); xline(12,'r');xline(32,'r');
    hold off; grid on; xlabel('Frequency (Hz)'); ylabel('Power/Frequency'); xlim(flim); 
    legend(["O1","O2"]); 

    subplot(5,2,6); hold on;
    plot(freq2(:,11),PSD_EEG2(:,11));
    plot(freq2(:,12),PSD_EEG2(:,12));
    xline(0.5,'r'); xline(4,'r'); xline(8,'r'); xline(12,'r');xline(32,'r');
    hold off; grid on; xlabel('Frequency (Hz)'); ylabel('Power/Frequency'); xlim(flim); 
    legend(["O1","O2"]); 

    subplot(5,2,7); hold on; 
    plot(freq1(:,13),PSD_EEG1(:,13));
    plot(freq1(:,14),PSD_EEG1(:,14));
    plot(freq1(:,15),PSD_EEG1(:,15));
    xline(0.5,'r'); xline(4,'r'); xline(8,'r'); xline(12,'r');xline(32,'r');
    hold off; grid on; xlabel('Frequency (Hz)'); ylabel('Power/Frequency'); xlim(flim); 
    legend(["P3","P4","PZ"]); 

    subplot(5,2,8); hold on; 
    plot(freq2(:,13),PSD_EEG2(:,13));
    plot(freq2(:,14),PSD_EEG2(:,14));
    plot(freq2(:,15),PSD_EEG2(:,15));
    xline(0.5,'r'); xline(4,'r'); xline(8,'r'); xline(12,'r');xline(32,'r');
    hold off; grid on; xlabel('Frequency (Hz)'); ylabel('Power/Frequency'); xlim(flim); 
    legend(["P3","P4","PZ"]); 

    subplot(5,2,9); hold on; 
    plot(freq1(:,16),PSD_EEG1(:,16));
    plot(freq1(:,17),PSD_EEG1(:,17));
    plot(freq1(:,18),PSD_EEG1(:,18));
    plot(freq1(:,19),PSD_EEG1(:,19));
    xline(0.5,'r'); xline(4,'r'); xline(8,'r'); xline(12,'r');xline(32,'r');
    hold off; grid on; xlabel('Frequency (Hz)'); ylabel('Power/Frequency'); xlim(flim); 
    legend(["T3","T4","T5","T6"]); 

    subplot(5,2,10); hold on; 
    plot(freq2(:,16),PSD_EEG2(:,16));
    plot(freq2(:,17),PSD_EEG2(:,17));
    plot(freq2(:,18),PSD_EEG2(:,18));
    plot(freq2(:,19),PSD_EEG2(:,19));
    xline(0.5,'r'); xline(4,'r'); xline(8,'r'); xline(12,'r');xline(32,'r');
    hold off; grid on; xlabel('Frequency (Hz)'); ylabel('Power/Frequency'); xlim(flim); 
    legend(["T3","T4","T5","T6"]); 

end