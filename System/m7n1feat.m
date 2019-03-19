function [feat] = m7n1feat(eegraw)
%   Band power of beta and alpha 14 channel EEG data
%   Detailed explanation goes here

    channels = [1 2 3 4 5 6 7 8 9 10 11 12 13 14]; %choose the channels F3 FC5 AF3 F7 T7 P7 O1 O2 P8 T8 F8 AF4 FC6 F4

    eegfilt = zeros(length(eegraw),14);
    for ch_itr = channels
        eegfilt(:,ch_itr) = detrend(eegraw(:,ch_itr));
    end
    
    fv_itr = 0;

    %Feature EXTRACTION
     for ch_itr = channels
        fv_itr = fv_itr + 1;
        betapow = bandpower(eegfilt(:,ch_itr),128,[14 30]);
        alphapow = bandpower(eegfilt(:,ch_itr),128,[8 12]);
        f1(fv_itr) = betapow;
        f2(fv_itr) = alphapow;
    end
    %until here
    
    %Write feature vector
    feat = [f1 f2];
end
