clear; clc;
%% Preparing Data
emg_data1 = readmatrix('data/subject01.csv');
emg_data2 = readmatrix('data/subject02.csv');
emg_data3 = readmatrix('data/subject03.csv');
fs = 2000;

trials_subject_1 = selective_feature(emg_data1, fs);
trials_subject_2 = selective_feature(emg_data2, fs);
trials_subject_3 = selective_feature(emg_data3, fs);
%% Splitting Data and Labeling

emg_data = [
    labeling_data(trials_subject_1);
    labeling_data(trials_subject_2);
    labeling_data(trials_subject_3);
    ];
% Split data
pre_train = 0.8 * length(emg_data);

train_emg_data = emg_data(1:round(pre_train), :);
test_emg_data =  emg_data(round(pre_train):end, :);

%% Exploring data and preprocessing
emg_data = rmoutliers(emg_data, 'quartiles');
emg_fatigue = emg_data(find(emg_data(:, 3) == 1),:);
emg_normal = emg_data(find(emg_data(:, 3) == 0),:);


figure(1);
plot(emg_normal(:, 1), emg_normal(:, 2), '*r'); hold on;
plot(emg_fatigue(:, 1), emg_fatigue(:, 2), 'ob'); hold off;
title('RMS VS SSC Without Outlier'); legend('Noraml EMG','Fatigue EMG');
xlabel('RMS'); ylabel('SSC'); grid on; hold off;


%% Build Model
% In this section we build the machine learing model.
% We are use very simple machine learning algorthims such as SVM or LDR
% becuase the linear relationship between the features.
X = train_emg_data(:, 1:2);
Y = train_emg_data(:, 3);
% 
% rng default
% % SVM
% SVMModel = fitcsvm(X,Y,'OptimizeHyperparameters','auto', ...
%     'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName', ...
%     'expected-improvement-plus'))
% CVSVMModel = crossval(SVMModel);
% classLoss = kfoldLoss(CVSVMModel)
% 
% % Trees
% Mdl = fitctree(X,Y,'OptimizeHyperparameters','auto')
