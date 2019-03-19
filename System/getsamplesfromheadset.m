function [eegraw] = getsamplesfromheadset(number_of_samples,cykit)
%GETSAMPLESFROMHEADSET return the supplied number of samples live from the headset
%Optimised Multiple times for performance to perfection.

%following lines to grab certain num of samples from headset

stored_eeg_chunk(1,:) = cell(cykit.get_data()); %first sample
n=2;
while n <= number_of_samples
    current_buffer = cell(cykit.get_data()); %current sample
    if stored_eeg_chunk{n-1,1} ~= current_buffer{1,1}  %check to see if new sample has arrived
        stored_eeg_chunk(n,:) = current_buffer;        %write new sample in next location
        n = n + 1;
    end
end
eegraw = cell2mat(stored_eeg_chunk);
end

