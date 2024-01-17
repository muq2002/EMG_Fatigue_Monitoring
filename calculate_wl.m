function out = calculate_wl(signal)
    wl = 0;              
    for i=2:length(signal)
        wl= wl + (signal(i)-signal(i-1));
    end
    out = wl;
end