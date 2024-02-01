clear; clc; close all;

%% Reading Data
emg_data = readmatrix('data/subject03m.csv');
fs = 2000;
number_samples = length(emg_data);

channel_1 = emg_data(:,2);
channel_2 = emg_data(:,3);

n = 1:number_samples;
channel_1_ftt = abs(fft(channel_1));
channel_2_ftt = abs(fft(channel_2));

figure(1);
subplot(2,2,1); plot(channel_1); title('EMG Channel 1'); axis tight; grid on;

subplot(2,2,2); plot((n*fs/number_samples), channel_1_ftt, '-r'); grid on;
axis([0 1000 0 800]) ,xlabel('Freq.'),ylabel('Magnitude'),title('FFT Channel 1')

subplot(2,2,3); plot(channel_2); title('EMG Channel 2'); axis tight; grid on;

subplot(2,2,4); plot((n*fs/number_samples), channel_2_ftt, '-r'); grid on;
axis([0 1000 0 800]),xlabel('Freq.'),ylabel('Magnitude'),title('FFT Channel 2');


%% Segmentations 
% Window size recommanded 0.5 - 2.5 second which mean 2 second
time_measure = length(emg_data) / fs;
window_size = 2 * fs;
number_window = floor(length(emg_data) / window_size);

trials_channel_1 = slicing_windows(channel_1, window_size, number_window);
trials_channel_2 = slicing_windows(channel_2, window_size, number_window);

figure(2);
subplot(2,2,1); plot(trials_channel_1(3, :)),axis tight,title('EMG Channel 1 Win. 3');
subplot(2,2,2); plot(trials_channel_1(8, :)),axis tight,title('EMG Channel 1 Win. 8');
subplot(2,2,3); plot(trials_channel_2(3, :), '-r'),axis tight,title('EMG Channel 2 Win. 3');
subplot(2,2,4); plot(trials_channel_2(8, :), '-r'),axis tight,title('EMG Channel 2 Win. 8');

%% Features Selection

features_channel_1 = zeros(number_window, 8);
features_channel_2 = zeros(number_window, 8);

for selected_window = 1:number_window
    features_channel_1(selected_window, :) =  ... 
        calcalate_features(trials_channel_1(selected_window, :), fs);
    features_channel_2(selected_window, :) =  ... 
        calcalate_features(trials_channel_2(selected_window, :), fs);
end

figure(3);
subplot(2,2, 1);
plot(features_channel_1(1:15,3), features_channel_1(1:15,4),'*r'); hold on;
plot(features_channel_1(15:end,3), features_channel_1(15:end,4),'ob');
title('Channel 1: RMS VS ZC'); legend('Noraml EMG','Fatigue EMG');
xlabel('RMS'); ylabel('ZC'); grid on; hold off;

subplot(2,2, 2);
plot(features_channel_1(1:15,3), features_channel_1(1:15,5),'*r'); hold on;
plot(features_channel_1(15:end,3), features_channel_1(15:end,5),'ob');
title('Channel 1: RMS VS SSC'); legend('Noraml EMG','Fatigue EMG');
xlabel('RMS'); ylabel('SSC'); grid on; hold off;

figure(4);
subplot(2,2, 1);
plot(features_channel_2(1:15,3), features_channel_2(1:15,4),'*r'); hold on;
plot(features_channel_2(15:end,3), features_channel_2(15:end,4),'ob');
title('Channel 2: RMS VS ZC');legend('Noraml EMG', 'Fatigue EMG');
xlabel('RMS'); ylabel('ZC'); grid on; hold off;

subplot(2,2, 2);
plot(features_channel_2(1:15,3), features_channel_2(1:15,5),'*r'); hold on;
plot(features_channel_2(15:end,3), features_channel_2(15:end,5),'ob');
title('Channel 2: RMS VS SSC'); legend('Noraml EMG','Fatigue EMG');
xlabel('RMS'); ylabel('SSC'); grid on; hold off;

