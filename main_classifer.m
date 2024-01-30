clear; clc;
%% Preparing Data
emg_data1 = readmatrix('data/subject01.csv');
emg_data2 = readmatrix('data/subject02.csv');

fs = 2000;

trials_subject_1 = selective_feature(emg_data1, fs);
trials_subject_2 = selective_feature(emg_data2, fs);

%% Splitting Data and Labeling
total_number_of_rows = length(trials_subject_1) + length(trials_subject_2);
emg_data = zeros(total_number_of_rows, 3);

% Make the data in table
emg_data(1:length(trials_subject_1), 1:2) = [trials_subject_1];
emg_data(length(trials_subject_1) + 1:end, 1:2) = [trials_subject_2];

% Labeling Data as 1 = fatigue; 0 = normal
half_of_emg1 = length(trials_subject_1) / 2;
half_of_emg2 = length(trials_subject_2) / 2;

emg_data(half_of_emg1:length(trials_subject_1) -1 , 3) = ones(half_of_emg1, 1);
emg_data((half_of_emg2 + length(trials_subject_1) + 1): end, 3) ... 
    = ones(half_of_emg2, 1);

% Split data
pre_train = 0.8 * length(emg_data);

train_emg_data = emg_data(1:round(pre_train), :);
test_emg_data =  emg_data(round(pre_train):end, :);

%% Build Model
% In this section we build the machine learing model.
% We are use very simple machine learning algorthims such as SVM or LDR
% becuase the linear relationship between the features.


