%follows from filecwt_trim2.m
% Import raw CSV file
input_data = csvread('mltest2_null.csv',1,0);
eegcols = 3:16; % EEG Columns.
fileread = input_data(:, eegcols);

number_of_samples = 256;                               
stepsize =number_of_samples;                            
samples = number_of_samples:stepsize:length(fileread);    

for kk = 1:length(samples)
    
    k = samples(kk);
    
    %polydetrend starts here
    eegraw = fileread(k-number_of_samples+1:k,:);

    order_of_polynomial = 6;
    t = 0:1/128:(number_of_samples-1)/128;
    t = t';

    eegfilt = zeros(length(eegraw),14);
    for polyitr=1:14
        [p,s,mu] = polyfit(t,eegraw(:,polyitr),order_of_polynomial);
        f_y = polyval(p,t,[],mu);
        eegfilt(:,polyitr) = eegraw(:,polyitr) - f_y;
    end
    %until here
    
    %CWT starts here
    
    waveletFunction = 'sym9'; %prevoiusly db8, https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4701319/
    for ch_itr = 1:14;
        [C,L] = wavedec(eegfilt(:,ch_itr),4,waveletFunction); %itrating through all the channels
        D1(:,ch_itr) = wrcoef('d',C,L,waveletFunction,1); %GAMMA
        D2(:,ch_itr) = wrcoef('d',C,L,waveletFunction,2); %BETA
        D3(:,ch_itr) = wrcoef('d',C,L,waveletFunction,3); %ALPHA
        D4(:,ch_itr) = wrcoef('d',C,L,waveletFunction,4); %THETA
        A4(:,ch_itr) = wrcoef('a',C,L,waveletFunction,4); %DELTA
    end
    
    figure(1);
    
    subplot(5,2,1); plot(1:1:length(D1), D1); title('GAMMA-AMPLITUDE');

    subplot(5,2,3); plot(1:1:length(D2), D2); title('BETA');

    subplot(5,2,5); plot(1:1:length(D3), D3); title('ALPHA'); 

    subplot(5,2,7); plot(1:1:length(D4), D4); title('THETA');

    subplot(5,2,9); plot(1:1:length(A4), A4); title('DELTA');

    xdft = fft(D1);
    freq = 0:128/length(D1):128/2;
    xdft = xdft(1:length(D1)/2+1,:);
    subplot(5,2,2);plot(freq,abs(xdft));title('GAMMA-FREQUENCY'); ylim([0 1000]);

    xdft2 = fft(D2);
    xdft2 = xdft2(1:length(D2)/2+1,:);
    subplot(5,2,4);plot(freq,abs(xdft2));title('BETA'); ylim([0 1000]);

    xdft3 = fft(D3);
    xdft3 = xdft3(1:length(D3)/2+1,:);
    subplot(5,2,6);plot(freq,abs(xdft3));title('ALPHA'); ylim([0 1000]);
    
    xdft4 = fft(D4);
    xdft4 = xdft4(1:length(D4)/2+1,:);
    subplot(5,2,8);plot(freq,abs(xdft4));title('THETA'); ylim([0 1000]);

    xdft5 = fft(A4);
    xdft5 = xdft5(1:length(A4)/2+1,:);
    subplot(5,2,10);plot(freq,abs(xdft5));title('DELTA'); ylim([0 1000]);
    %until here
    
end
