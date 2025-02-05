function [PSD_EEG, freq, df] = estimPSD(EEG, Fs, K)
   
    N= size(EEG,1); % number of samples for each deriv.
    nderiv = size(EEG,2); % number of deriv.
    
    % define parameters for PSD estimation:
    % Welch method (K windows, 50% overlap)
    noverlap = round(N/K/2); 
    M = round(N/K);
    
    % estimate the PSD for each deriv. 
    for i=[1:nderiv]
        [ PSD_EEG(:,i) , freq(:,i)] = pwelch(EEG(:,i),hamming(M),noverlap,[],Fs); % 50% overlap
    end 

    df = Fs/M;
    
end 