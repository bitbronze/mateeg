function [fileread] = getsamplesfromfile(filename)
% Import raw CSV file
input_data = csvread(filename,1,0);
eegcols = 3:16; % EEG Columns.
fileread = input_data(:, eegcols);
end

