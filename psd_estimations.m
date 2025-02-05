function psd_estimations(x,Fs, flim)

    N = round(length(x));
    t = (1:N)*Fs; 

    figure; 
    
    subplot(5,1,1); plot(t,x);
    xlabel('Time [s]'); ylabel('Amplitude [a.u.]'); title('x_n'); xlim([0,length(x)*Fs]);

    [PSDx_sp,freq]=periodogram(x,rectwin(N),N,Fs); %nfft = N (no zero padding)

    % windowing with Bartlett approach
    noverlap = 0;
    K = 15; M = round(N/K); [PSDb_1,f1] = pwelch(x,rectwin(M),noverlap,[],Fs); 
    K = 18; M = round(N/K); [PSDb_2,f2] = pwelch(x,rectwin(M),noverlap,[],Fs); 

    subplot(5,1,2); hold on; title('Bartlett - no overlapp');
    plot(freq,PSDx_sp); grid on; xlabel('Frequency (Hz)'); ylabel('Power/Frequency');
    plot(f1,PSDb_1); grid on; xlabel('Frequency (Hz)'); ylabel('Power/Frequency');
    plot(f2,PSDb_2); grid on; xlabel('Frequency (Hz)'); ylabel('Power/Frequency');
    legend(["Periodogram","15 windows", "18 windows"]); hold off; xlim(flim);

    % windowing with Welch approach
    K = 15; noverlap = round(N/K/2);  M = round(N/K);
    [PSDw_3,f3] = pwelch(x,hamming(M),noverlap,[],Fs); % 50% overlap

    K = 18; noverlap = round(N/K/2);  M = round(N/K);
    [PSDw_4,f4] = pwelch(x,blackman(M),noverlap,[],Fs); % 50% overlap

    K = 19; noverlap = round(N/K/2);  M = round(N/K);
    [PSDw_5,f5] = pwelch(x,hamming(M),noverlap,[],Fs); % 50% overlap

    K = 19; noverlap = round(N/K/2);  M = round(N/K);
    [PSDw_6,f6] = pwelch(x,blackman(M),noverlap,[],Fs); % 50% overlap

    subplot(5,1,3); hold on;
    plot(f3,PSDw_3); 
    plot(f4,PSDw_4); 
    plot(f5,PSDw_5); 
    plot(f6,PSDw_6); 
    grid on; xlabel('Frequency (Hz)'); legend(["15 hamming wind.", "18 blackman wind.", "19 hamming wind." , "19 blackman wind."]); 
    ylabel('Power/Frequency'); xlim(flim); title("Welch - 50% overlapp");

    % indirect method Wiener-Khinchin Theorem with windowing 
    [r,~] = xcorr(x,x,'biased');
    DTFx_indirect = abs(fft(r));
    freq2 = 0:Fs/length(DTFx_indirect):Fs/2;
    
    PSDx_indirect = (1/Fs)*DTFx_indirect(1:length(DTFx_indirect)/2+1);
    PSDx_indirect(2:end) = 2*PSDx_indirect(2:end); % to get all the energy

    subplot(5,1,4);
    plot(freq2,PSDx_indirect); title('Indirect method (Wiener-Khinchin Theorem)');
    ylabel('Power/Frequency'); xlabel('Frequency (Hz)'); xlim(flim);

    % parametric approach
    subplot(5,1,5); 
    hold on;
    for order = [8,16,32,64]
        [Pxx2,f] = pyulear(x,order,1024,Fs);
        Pxx2(2:end) = 2*Pxx2(2:end);
        plot(f,abs(Pxx2)); 
    end
    xlabel('frequency kHz');ylabel ('power/frequency dB/Hz');xlim(flim);
    title ('pyulear PSD');
    legend({'Order 8','Order 16','Order 32','Order 64'});

end