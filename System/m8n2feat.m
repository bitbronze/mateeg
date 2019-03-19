function [feat] = m8n2feat(eegraw)
%   Band power percentage of beta and alpha 2 channel EEG data optimised for left right
%   Detailed explanation goes here

    channels = [2 13]; %choose the channels F3 FC5 AF3 F7 T7 P7 O1 O2 P8 T8 F8 AF4 FC6 F4

    eegfilt = zeros(length(eegraw),14);
    for ch_itr = channels
        eegfilt(:,ch_itr) = detrend(eegraw(:,ch_itr));
    end
    
    fv_itr = 0;

    %Feature EXTRACTION
        betapowfc5 = bandpower(eegfilt(:,2),128,[14 30]);
        alphapowfc5 = bandpower(eegfilt(:,2),128,[8 12]);
        betapowfc6 = bandpower(eegfilt(:,13),128,[14 30]);
        alphapowfc6 = bandpower(eegfilt(:,13),128,[8 12]);
        totalpowfc5 = bandpower(eegfilt(:,2),128,[7 32]);
        totalpowfc6 = bandpower(eegfilt(:,13),128,[7 32]);
        betapowfc5 = (betapowfc5/totalpowfc5)*100;
        betapowfc6 = (betapowfc6/totalpowfc6)*100;
        alphapowfc5 = (alphapowfc5/totalpowfc5)*100;
        alphapowfc6 = (alphapowfc6/totalpowfc6)*100;
        bp1 = betapowfc5 - betapowfc6;
        bp2 = alphapowfc5 - alphapowfc6;
        bp3 = mean([betapowfc5 betapowfc6]);
        bp4 = mean([alphapowfc5 alphapowfc6]);
    %until here
    
    %Write feature vector
    feat = [bp1 bp2 bp3 bp4];
end
