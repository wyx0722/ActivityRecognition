close all;
clear;
clc;

% for HOG
files = dir('*_hog_hists.mat');
load('1_1_hog_hists.mat');
allhogs_tra = allframe_hists;
for fnum = 1:numel(files)
    [pathstr,name,ext] = fileparts(files(fnum).name);
    histname = name;
    histfile = strcat(histname,'.mat');
    load(histfile); %allframe_hists
    %concatenate the hog hists from the training videos
    if strcmp(histname(2:2), '_') && str2double(histname(1:1)) < 7 && ~strcmp(histname(1:3), '1_1')
        vertcat(allhogs_tra, allframe_hists);
    end
end

% Do kmeans clustering
[idx,C] = kmeans(allhogs_tra, 25);

for fnum = 1:numel(files)
    [pathstr,name,ext] = fileparts(files(fnum).name);
    histname = name;
    histfile = strcat(histname,'.mat');
    load(histfile); %allframe_hists
    numframes = size(allframe_hists, 1);
    my_hist = zeros(1,25);
    for i = 1:numframes
        % Calculate frame hist distance from cluster centers
        distances = zeros(1,25);
        for j = 1:25
            distances(j) = sum((allframe_hists(i,:) - C(j,:)).^2);
        end
        % Find the shortest distance
        [min_val, min_idx] = min(distances);
        % Cast vote
        my_hist(min_idx) = my_hist(min_idx) + 1;
    end
    my_hist = my_hist./numframes; %normalize
    
    save(strcat(histname, '_bog.mat'), 'my_hist'); %export the histograms as matricies
    
    % Save histograms to word file
%     fileID = fopen('BOW.txt', 'a');
%     fprintf(fileID, '%s\n', strcat('BOW_HOG_',regexprep(histname, '_hog_hists', ''), '=['));
%     fprintf(fileID, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n', my_hist);
%     fprintf(fileID, '%s\n', '];');
%     fclose(fileID);
end

% for HOF
files = dir('*_hof_hists.mat');
load('1_1_hof_hists.mat');
allhogs_tra = allframe_hists;
for fnum = 1:numel(files)
    [pathstr,name,ext] = fileparts(files(fnum).name);
    histname = name;
    histfile = strcat(histname,'.mat');
    load(histfile); %allframe_hists
    %concatenate the hof hists from the training videos
    if strcmp(histname(2:2), '_') && str2double(histname(1:1)) < 7 && ~strcmp(histname(1:3), '1_1')
        vertcat(allhogs_tra, allframe_hists);
    end
end

% Do kmeans clustering
[idx,C] = kmeans(allhogs_tra, 25);

for fnum = 1:numel(files)
    [pathstr,name,ext] = fileparts(files(fnum).name);
    histname = name;
    histfile = strcat(histname,'.mat');
    load(histfile); %allframe_hists
    numframes = size(allframe_hists, 1);
    my_hist = zeros(1,25);
    for i = 1:numframes
        distances = zeros(1,25);
        for j = 1:25
            distances(j) = sum((allframe_hists(i,:) - C(j,:)).^2);
        end
        [min_val, min_idx] = min(distances);
        my_hist(min_idx) = my_hist(min_idx) + 1;
    end
    my_hist = my_hist./numframes; %normalize
    
    save(strcat(histname, '_bog.mat'), 'my_hist'); %export the histograms as matricies
    
    % Save histograms to word file
%     fileID = fopen('BOW.txt', 'a');
%     fprintf(fileID, '%s\n', strcat('BOW_HOF_',regexprep(histname, '_hof_hists', ''), '=['));
%     fprintf(fileID, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n', my_hist);
%     fprintf(fileID, '%s\n', '];');
%     fclose(fileID);
end
