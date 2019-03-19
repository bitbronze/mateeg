function [feat] = m1n1feat(eegraw)
%   Statistical feature extraction after using xcorr on from 14 channel EEG data
%   Detailed explanation goes here

    channels = [1 2 3 4 5 6 7 8 9 10 11 12 13 14]; %choose the channels F3 FC5 AF3 F7 T7 P7 O1 O2 P8 T8 F8 AF4 FC6 F4

    eegfilt = zeros(length(eegraw),14);
    for ch_itr = channels
        eegfilt(:,ch_itr) = smartfilter(eegraw(:,ch_itr));
    end
    
    fv_itr = 0;
    
    %corr starts here
    for ch_itr = channels
        eegcorr(:,ch_itr) = xcorr(eegfilt(:,1), eegfilt(:,ch_itr)); %crosscorr with F3
    end
    eegcorr = abs(eegcorr); %important quirk
    %until here
    
    %Feature EXTRACTION
     for ch_itr = channels
        fv_itr = fv_itr + 1;
        f1(fv_itr) = mean(eegcorr(:,ch_itr));
        f2(fv_itr) = median(eegcorr(:,ch_itr));
        f3(fv_itr) = std(eegcorr(:,ch_itr));
        f4(fv_itr) = max(eegcorr(:,ch_itr));
        f5(fv_itr) = min(eegcorr(:,ch_itr));
    end
    %until here
    
    %Write feature vector
    feat = [f1 f2 f3 f4 f5];
end
