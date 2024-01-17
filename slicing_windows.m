function out = slicing_windows(signal, window_size,  number_window)
    trials_channel = zeros(number_window, window_size);
    start_window = 1;
    for sample = 1:number_window
        end_window = (start_window + window_size - 1);
        trials_channel(sample, :) = signal(start_window:end_window);
        start_window = window_size * sample;
    end
    out =  trials_channel;
end