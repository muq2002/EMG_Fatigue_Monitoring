function out = selective_feature(emg_data, fs)
    % Split into channels
    channel_1 = emg_data(:,2); % channel 1
    channel_2 = emg_data(:,3); % chanenl 2

    % Segmentation
    window_size = 2 * fs;
    number_window = floor(length(emg_data) / window_size);

    trials_channel_1 = slicing_windows(channel_1, window_size, number_window);
    trials_channel_2 = slicing_windows(channel_2, window_size, number_window);
    
    % Selecte Features
    features_channel_1 = zeros(number_window, 8);
    features_channel_2 = zeros(number_window, 8);

    % Calculate all the features of emg by `calculate_features()`
    for selected_window = 1:number_window
        features_channel_1(selected_window, :) =  ... 
            calcalate_features(trials_channel_1(selected_window, :), fs);
        features_channel_2(selected_window, :) =  ... 
            calcalate_features(trials_channel_2(selected_window, :), fs);
    end
    % I select the index is 3 to RMS feature and index 4 to ZC feature
    out = [features_channel_1(:,1:8); features_channel_2(:,1:8)];
end