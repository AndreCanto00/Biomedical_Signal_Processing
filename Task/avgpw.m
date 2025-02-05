function [perc, pwband, totpw] = avgpw(PSD, f, band)
    % band is a two elment vector defining the bandwidth of interest
    % PSD is a matrix M x 19 derivations 
    % the function return the area underneath the PSD in the bw of interest

    totpw = sum(PSD); % column-wise sum 

    PSDcut = PSD((f>=band(1) & f<=band(2)),:);
    pwband = sum(PSDcut); % column-wise sum

    perc = pwband./totpw;

end
