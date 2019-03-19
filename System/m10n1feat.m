function [feat] = m10n1feat(eegraw)
%   Feature aggregte

    channels = [1 2 3 4 5 6 7 8 9 10 11 12 13 14]; %choose the channels F3 FC5 AF3 F7 T7 P7 O1 O2 P8 T8 F8 AF4 FC6 F4

    eegfilt = zeros(length(eegraw),14);
    for ch_itr = channels
        eegfilt(:,ch_itr) = smartfilter(eegraw(:,ch_itr));
        eegabs(:,ch_itr) = abs(eegfilt(:,ch_itr));
    end
    
    waveletFunction = 'sym9';
    for ch_itr = channels
        [C,L] = wavedec(eegfilt(:,ch_itr),4,waveletFunction); %itrating through all the channels
        cD1(:,ch_itr) = detcoef(C,L,1);%GAMMA
        cD2(:,ch_itr) = detcoef(C,L,2);%BETA
        cD3(:,ch_itr) = detcoef(C,L,3);%ALPHA
        cD4(:,ch_itr) = detcoef(C,L,4);%THETA
        cA4(:,ch_itr) = appcoef(C,L,waveletFunction,4); %DELTA
    end
    
    fv_itr = 0;

    %Feature EXTRACTION
     for ch_itr = channels
        fv_itr = fv_itr + 1;
        
        %Band Power
        f1(fv_itr) = bandpower(eegfilt(:,ch_itr),128,[32 64]); %gamma
        f2(fv_itr) = bandpower(eegfilt(:,ch_itr),128,[16 32]); %beta
        f3(fv_itr) = bandpower(eegfilt(:,ch_itr),128,[8 16]); %alpha
        f4(fv_itr) = bandpower(eegfilt(:,ch_itr),128,[4 8]); %theta
        f5(fv_itr) = bandpower(eegfilt(:,ch_itr),128,[0 4]); %delta
        
        %Statistics
        f6(fv_itr) = mean(eegabs(:,ch_itr));
        f7(fv_itr) = std(eegabs(:,ch_itr));
        f8(fv_itr) = mean(abs(diff(eegabs(:,ch_itr))));
        stdeegabs(:,ch_itr) = (eegabs(:,ch_itr) - mean(eegabs(:,ch_itr)))./(std(eegabs(:,ch_itr)));
        f9(fv_itr) = mean(abs(diff(stdeegabs(:,ch_itr))));
        f10(fv_itr) = mean(abs(diff(eegfilt(:,ch_itr),2)));
        f11(fv_itr) = mean(abs(diff(stdeegabs(:,ch_itr),2)));
        
        %Wavelet
        f12(fv_itr) = sum((abs(cD1(:,ch_itr))).^2); %energy
        f13(fv_itr) = -sum(((abs(cD1(:,ch_itr))).^2).*((log(abs(cD1(:,ch_itr))).^2))); %entropy
        
        f14(fv_itr) = sum((abs(cD2(:,ch_itr))).^2); %energy
        f15(fv_itr) = -sum(((abs(cD2(:,ch_itr))).^2).*((log(abs(cD2(:,ch_itr))).^2))); %entropy
        
        f16(fv_itr) = sum((abs(cD3(:,ch_itr))).^2); %energy
        f17(fv_itr) = -sum(((abs(cD3(:,ch_itr))).^2).*((log(abs(cD3(:,ch_itr))).^2))); %entropy
        
        f18(fv_itr) = sum((abs(cD4(:,ch_itr))).^2); %energy
        f19(fv_itr) = -sum(((abs(cD4(:,ch_itr))).^2).*((log(abs(cD4(:,ch_itr))).^2))); %entropy
        
        f20(fv_itr) = sum((abs(cA4(:,ch_itr))).^2); %energy
        f21(fv_itr) = -sum(((abs(cA4(:,ch_itr))).^2).*((log(abs(cA4(:,ch_itr))).^2))); %entropy
        
    end
    %until here
    
    %Write feature vector
    feat = [f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 f12 f13 f14 f15 f16 f17 f18 f19 f20 f21];
end
