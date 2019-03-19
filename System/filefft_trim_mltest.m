% Import raw CSV file
clearvars -except
input_data = csvread('mltest2_null.csv',1,0); % This excludes the first row
eegcols = 3:16; % EEG Columns.
fileread = input_data(:, eegcols);

% Variables
number_of_samples = 32;                               
stepsize =number_of_samples;                            
samples = number_of_samples:stepsize:length(fileread);

c = 1:number_of_samples;
channel = [1 2 3 4 5 6 7 8 9 10 11 12 13 14]; %to display

%Specify hanning window
hanning = [1:number_of_samples]';
hanning_in = 2* pi() * (hanning - ((number_of_samples+1)/2))/(number_of_samples+1); %negative pi to pi, mapped over fftlength
%rescaled x-axis to match sample length?
hanning = (sin(hanning_in)./hanning_in).^2;    % sinc^2? (raised Cosine?)
hanning = repmat(hanning, 1, size(fileread,2)); % match to number of channels
f=[128/number_of_samples:128/number_of_samples:128];           % frequency index for the spectral array


for kk = 1:length(samples)
    k = samples(kk);
    
    %polydetrend starts here
    order_of_polynomial = 6;
    t = 0:1/128:(number_of_samples-1)/128; %maptime values to all samples
    t = t';

    for polyitr=1:14
    [p,s,mu] = polyfit(t,fileread(k-number_of_samples+1:k,polyitr),order_of_polynomial);
    f_y = polyval(p,t,[],mu);
    eegfilt(:,polyitr) = fileread(k-number_of_samples+1:k,polyitr) - f_y;
    end
    %until here
    
    spectrum = fft(eegfilt .* hanning)/number_of_samples;
    spectrum = 2 * (sqrt(spectrum .* conj(spectrum))); 
    
    figure(1);
    %plotting the time domain and IIR FFT data
    subplot(211)

    plot(c,eegfilt(:,channel));
    title('Amplitude of Channels');
    xlabel('Samples');
    ylabel('Amplitude');
    xlim([0 number_of_samples]);

    subplot(212)
    plot(f,spectrum(:, channel));
    title('Amplitude Spectrum of Channels');
    xlabel('Frequency (Hz)');
    ylabel('|Y(f)|');
    xlim([0 50]);
    ylim([0 4]);
%     pause(number_of_samples/128);
end
