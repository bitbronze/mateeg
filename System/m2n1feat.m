function [feat] = m2n1feat(eegraw)
%   DWT for band seperation, then band power ratios 14 channel EEG data
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
        [C,L] = wavedec(eegfilt(:,ch_itr),4,waveletFunction); %itrating through all the channels
        D1(:,ch_itr) = wrcoef('d',C,L,waveletFunction,1); %GAMMA
        D2(:,ch_itr) = wrcoef('d',C,L,waveletFunction,2); %BETA
        D3(:,ch_itr) = wrcoef('d',C,L,waveletFunction,3); %ALPHA
        D4(:,ch_itr) = wrcoef('d',C,L,waveletFunction,4); %THETA
        A4(:,ch_itr) = wrcoef('a',C,L,waveletFunction,4); %DELTA
    end
    %until here
    
    %Feature EXTRACTION
     for ch_itr = channels
        fv_itr = fv_itr + 1;
        gammapow = bandpower(D1(:,ch_itr),128,[32 48]);
        betapow = bandpower(D2(:,ch_itr),128,[16 32]);
        alphapow = bandpower(D3(:,ch_itr),128,[8 16]);
        mupow = bandpower(D3(:,ch_itr),128,[9 12]);
        thetapow = bandpower(D4(:,ch_itr),128,[4 8]);
        deltapow = bandpower(A4(:,ch_itr),128,[0 4]);
        f1(fv_itr) = gammapow/thetapow;
        f2(fv_itr) = betapow/thetapow;
        f3(fv_itr) = alphapow/thetapow;
        f4(fv_itr) = mupow/thetapow;
        f5(fv_itr) = deltapow/thetapow;

        
    end
    %until here
    
    %Write feature vector
    feat = [f1 f2 f3 f4 f5];
end
