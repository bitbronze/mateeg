function [feat] = m3n1feat(eegraw)
%   Band power percentage of all bands 14 channel EEG data
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
        gammapow = bandpower(eegfilt(:,ch_itr),128,[32 48]);
        betapow = bandpower(eegfilt(:,ch_itr),128,[16 32]);
        alphapow = bandpower(eegfilt(:,ch_itr),128,[8 16]);
        mupow = bandpower(eegfilt(:,ch_itr),128,[9 12]);
        thetapow = bandpower(eegfilt(:,ch_itr),128,[4 8]);
        deltapow = bandpower(eegfilt(:,ch_itr),128,[0 4]);
        totalpow = bandpower(eegfilt(:,ch_itr),128,[0 48]);
        f1(fv_itr) = (gammapow/totalpow)*100;
        f2(fv_itr) = (betapow/totalpow)*100;
        f3(fv_itr) = (alphapow/totalpow)*100;
        f4(fv_itr) = (mupow/totalpow)*100;
        f5(fv_itr) = (thetapow/totalpow)*100;
        f6(fv_itr) = (deltapow/totalpow)*100;
    end
    %until here
    
    %Write feature vector
    feat = [f1 f2 f3 f4 f5 f6];
end
