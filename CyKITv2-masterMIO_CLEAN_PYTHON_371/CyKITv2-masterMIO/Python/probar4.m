clear classes;
addpath_recurse(); %add paths to python interpreter

% py.importlib.import_module('eeg'); %just to check if module loads (not
% needed)

cykit = py.eeg.EEG; %load class from python file as object cykit, to execute python from MATLAB
%get_data() is the function within that class that delivers the data
%CSV style.

%following lines to grab certain num of samples from headset
tic();
number_of_samples = 100;
stored_eeg_chunk = zeros(number_of_samples,18);

stored_eeg_chunk(1,:) = cell2mat(cell(cykit.get_data())); %first sample
n=2;
while n <= length(stored_eeg_chunk)
    current_buffer = cell2mat(cell(cykit.get_data())); %current sample
    if stored_eeg_chunk(n-1,1) ~= current_buffer(1,1)  %check to see if new sample has arrived
        stored_eeg_chunk(n,:) = current_buffer;        %write new sample in next location
        n = n + 1;
    end
end
toc();
%until here