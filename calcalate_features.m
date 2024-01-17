function out = calcalate_features(signal, fs) % fs = 2000
    result = zeros(1,8);
    %Store basic feauters
    result(1, 1) = rms(signal);
    result(1, 2) = mean(signal);
    result(1, 3) = std(signal);
    result(1, 4) = rms(signal);
    
    %Store EMG signal features
    result(1, 5) = calculate_zc(signal);
    % fs  of signal 
    result(1, 6) = medfreq(signal, fs); 
    result(1, 7) = meanfreq(signal); 
    result(1, 8) = calculate_wl(signal);
    
    out = result;
end