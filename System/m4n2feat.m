function [feat] = m4n2feat(eegraw)
%   Statistical feature extraction (2nd differences etc) from 2 channel EEG data
%   Detailed explanation goes here

    channels = [2 13]; %choose the channels F3 FC5 AF3 F7 T7 P7 O1 O2 P8 T8 F8 AF4 FC6 F4

    eegfilt = zeros(length(eegraw),14);
    for ch_itr = channels
        eegfilt(:,ch_itr) = detrend(eegraw(:,ch_itr));
    end
    
    fv_itr = 0;
    
    %Feature EXTRACTION
     for ch_itr = channels
        fv_itr = fv_itr + 1;
        f1(fv_itr) = mean(eegfilt(:,ch_itr));
        f2(fv_itr) = std(eegfilt(:,ch_itr));
        f3(fv_itr) = mean(abs(diff(eegfilt(:,ch_itr))));
        stdeegfilt(:,ch_itr) = (eegfilt(:,ch_itr) - mean(eegfilt(:,ch_itr)))./(std(eegfilt(:,ch_itr)));
        f4(fv_itr) = mean(abs(diff(stdeegfilt(:,ch_itr))));
        f5(fv_itr) = mean(abs(diff(eegfilt(:,ch_itr),2)));
        f6(fv_itr) = mean(abs(diff(stdeegfilt(:,ch_itr),2)));
    end
    %until here
    
    %Write feature vector
    feat = [f1 f2 f3 f4 f5 f6];
end
