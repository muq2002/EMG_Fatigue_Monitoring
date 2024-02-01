function out = labeling_data(signal)
    total_number_of_rows = length(signal);
    emg_data = zeros(total_number_of_rows, 3);
    
    % Apply the fatigue condition on data where is the first the windows is
    % normal emg and last window is fatigue emg.
    half_of_emg = length(signal) / 2;
    emg_data(:, 1:2) = signal;
    
    % Labeling Data as 1 = fatigue; 0 = normal
    emg_data(half_of_emg + 1:end , 3) = ones(half_of_emg, 1);
    
    out = emg_data;
end