function [EEG, dervs]=set_data(filename)
    
    % the function reads from a file Subject0x_x.mat the EEG recordings
    % from all drivations and stores them as columns in the matrix EEG

    % EEG m x n
    % n= number of derivations (19)
    % m= number of samples for each derivation

    % each column in EEG is a derivation from the corresponding location in
    % dervs

    % load data
    data = load(filename);

    % data is a struct containing 19 derivations x EEG signal 91000 samples 
    dervs = ["C3", "C4", "CZ", "F3" , "F4", "F7", "F8", "FP1", "FP2","FZ","O1","O2","P3","P4","PZ","T3","T4","T5","T6"];
    EEG = [ data.C3' ; data.C4' ; data.CZ'; data.F3'; data.F4'; data.F7'; data.F8'; data.FP1'; data.FP2'; data.FZ'; data.O1'; data.O2'; data.P3'; data.P4'; data.PZ'; data.T3'; data.T4'; data.T5'; data.T6']';

end
