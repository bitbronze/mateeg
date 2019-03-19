function [feat] = m7n2feat(eegraw)
%   Band power of beta and alpha 2 channel EEG data optimised for left right
%   Detailed explanation goes here

    channels = [2 13]; %choose the channels F3 FC5 AF3 F7 T7 P7 O1 O2 P8 T8 F8 AF4 FC6 F4

    eegfilt = zeros(length(eegraw),14);
    for ch_itr = channels
        eegfilt(:,ch_itr) = detrend(eegraw(:,ch_itr));
    end

    %Feature EXTRACTION

        betapowfc5 = bandpower(eegfilt(:,2),128,[14 30]);
        alphapowfc5 = bandpower(eegfilt(:,2),128,[8 12]);
        betapowfc6 = bandpower(eegfilt(:,13),128,[14 30]);
        alphapowfc6 = bandpower(eegfilt(:,13),128,[8 12]);
        pow1 = betapowfc5 - betapowfc6;
        pow2 = alphapowfc5 - alphapowfc6;
        pow3 = mean([betapowfc5 betapowfc6]);
        pow4 = mean([alphapowfc5 alphapowfc6]);

    %until here
    
    %Write feature vector
    feat = [pow1 pow2 pow3 pow4];
end
