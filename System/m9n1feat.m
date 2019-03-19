function [feat] = m9n1feat(eegraw)
%   DWT, db4 for L3, cD3, cD2, then statistics 14 channel EEG data
%   Detailed explanation goes here

    channels = [1 2 3 4 5 6 7 8 9 10 11 12 13 14]; %choose the channels F3 FC5 AF3 F7 T7 P7 O1 O2 P8 T8 F8 AF4 FC6 F4

    eegfilt = zeros(length(eegraw),14);
    for ch_itr = channels
        eegfilt(:,ch_itr) = detrend(eegraw(:,ch_itr));
    end
    
    fv_itr = 0;
    
    %CWT starts here
    waveletFunction = 'sym9'; %prevoiusly db8, https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4701319/
    for ch_itr = channels
        [C,L] = wavedec(eegfilt(:,ch_itr),3,waveletFunction); %itrating through all the channels
        cD3(:,ch_itr) = detcoef(C,L,3);%ALPHA
        cD2(:,ch_itr) = detcoef(C,L,2);%BETA
    end
    %until here
    
    %Feature EXTRACTION
     for ch_itr = channels
        fv_itr = fv_itr + 1;
        det3 = abs(cD3(:,ch_itr));
        det2 = abs(cD2(:,ch_itr));
        f1(fv_itr) = mean(det3); 
        f2(fv_itr) = std(det3); 
        f3(fv_itr) = max(det3);
        f4(fv_itr) = min(det3); 
        f5(fv_itr) = mean(det2); 
        f6(fv_itr) = std(det2); 
        f7(fv_itr) = max(det2); 
        f8(fv_itr) = min(det2); 
    end
    %until here
    
    %Write feature vector
    feat = [f1 f2 f3 f4 f5 f6 f7 f8];
end
