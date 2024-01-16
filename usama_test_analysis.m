clear; clc; close all;

%% Reading Data
%emg_data =xlsread('usama_movement.csv');

fs = 2000;
number_samples = length(usamamovement);

channel_1 = usamamovement(:,2);
channel_2 = usamamovement(:,3);

n = 1:number_samples;
channel_1_ftt = abs(fft(channel_1));
channel_2_ftt = abs(fft(channel_2));

figure(1);
subplot(2,2,1); plot(channel_1),axis tight,title('EMG Channel 1');
subplot(2,2,3); plot(channel_2),axis tight,title('EMG Channel 2');

subplot(2,2,2); plot((n*fs/number_samples), channel_1_ftt, '-r');
axis([0 1000 0 800]) ,xlabel('Freq'),ylabel('Magnitude'),title('FFT Channel 1')

subplot(2,2,4); plot((n*fs/number_samples), channel_2_ftt, '-r');
axis([0 1000 0 800]),xlabel('Freq'),ylabel('Magnitude'),title('FFT Channel 2');


%% Segmentations 

time_measure = length(usamamovement)/fs;
% Window size recommanded 0.5 - 2.5 second which mean 2 second
window_size = 2 * fs;
number_window = floor(length(usamamovement) / window_size);

% For Channel 1

trials_channel_1 = zeros(number_window, window_size);
start_window = 1;
kk= zeros(30,7);
for sample = 1:number_window
    end_window = (start_window + window_size - 1);
    trials_channel_1(sample, :) = channel_1(start_window:end_window);
    [rootmean, mean_value, stdev,zc,mdf,mpf,wl]=calc(trials_channel_1(sample, :));
    disp('=rootmean, mean_value,   stdev,    zc,        mdf,     mpf,     wl');
    disp([rootmean, mean_value, stdev,zc,mdf,mpf,wl]);
    kk(sample,:)=[rootmean, mean_value, stdev,zc,mdf,mpf,wl];
    start_window = window_size * sample;

end
size(trials_channel_1);
disp(kk);
for i=1:7
    fprintf('   %f ',(max(kk(:,i)))); 
end
%disp(min(kk(:,1)))
disp(' ');
for i=1:7
    fprintf('   %f ',(min(kk(:,i)))); 
end


%%
% For  Channel 2
trials_channel_2 = zeros(number_window, window_size);
start_window = 1;
for sample = 1:number_window
    end_window = (start_window + window_size - 1);
    trials_channel_2(sample, :) = channel_2(start_window:end_window);
    start_window = window_size * sample;
end
size(trials_channel_2);

figure(2);
subplot(2,2,1); plot(trials_channel_1(3, :)),axis tight,title('EMG Channel 1 Win. 3');
subplot(2,2,2); plot(trials_channel_1(8, :)),axis tight,title('EMG Channel 1 Win. 8');
subplot(2,2,3); plot(trials_channel_2(3, :), '-r'),axis tight,title('EMG Channel 2 Win. 3');
subplot(2,2,4); plot(trials_channel_2(8, :), '-r'),axis tight,title('EMG Channel 2 Win. 8');











