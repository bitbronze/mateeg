function [feat] = m6n2feat(eegraw)
%   DWT, db4 for L3, cD3, then RMS 2 channel EEG data
%   Detailed explanation goes here

    channels = [2 13]; %choose the channels F3 FC5 AF3 F7 T7 P7 O1 O2 P8 T8 F8 AF4 FC6 F4

    eegfilt = zeros(length(eegraw),14);
    for ch_itr = channels
        eegfilt(:,ch_itr) = detrend(eegraw(:,ch_itr));
    end
    
    fv_itr = 0;
    
    %CWT starts here
    waveletFunction = 'db4'; %prevoiusly db8, https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4701319/
    for ch_itr = channels
        [C,L] = wavedec(eegfilt(:,ch_itr),3,waveletFunction); %itrating through all the channels
        cD3(:,ch_itr) = detcoef(C,L,3);%ALPHA
    end
    %until here
    
    %Feature EXTRACTION
     for ch_itr = channels
        fv_itr = fv_itr + 1;
        f1(fv_itr) = rms(cD3(:,ch_itr)); %RMS
    end
    %until here
    
    %Write feature vector
    feat = [f1];
end
