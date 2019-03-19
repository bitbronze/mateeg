%m11n1feat
clearvars -except trainedModel allfeatures rawdata*;
number_of_samples = size(rawdata1,1); %change and specify
number_of_trials = size(rawdata1,3);
totalguesses = 0;
correctguesses = 0;
%%
truelabel = {'null'};
fileread = rawdata1;                            
samples = number_of_samples:number_of_samples:length(fileread);    %samples means trials indexes

for k = 1:number_of_trials
    feat(k,:) = m11n1feat(rawdata1(:,3:16,k),number_of_samples);
end

currentfeatures = table(feat);
prediction1 = trainedModel.predictFcn(currentfeatures);

totalguesses = totalguesses + length(prediction1);

for i = 1:length(prediction1)
    if strcmp(truelabel,prediction1(i))
        correctguesses = correctguesses + 1;
    end
end

clear fileread samples kk k eegraw feat
%%
truelabel = {'right'};
fileread = rawdata2;                            
samples = number_of_samples:number_of_samples:length(fileread);    %samples means trials indexes

for k = 1:number_of_trials
    feat(k,:) = m11n1feat(rawdata2(:,3:16,k),number_of_samples);
end

currentfeatures = table(feat);
prediction2 = trainedModel.predictFcn(currentfeatures);

totalguesses = totalguesses + length(prediction2);

for i = 1:length(prediction2)
    if strcmp(truelabel,prediction2(i))
        correctguesses = correctguesses + 1;
    end
end

clear fileread samples kk k eegraw feat
%%
truelabel = {'left'};
fileread = rawdata3;                            
samples = number_of_samples:number_of_samples:length(fileread);    %samples means trials indexes

for k = 1:number_of_trials
    feat(k,:) = m11n1feat(rawdata3(:,3:16,k),number_of_samples);
end

currentfeatures = table(feat);
prediction3 = trainedModel.predictFcn(currentfeatures);

totalguesses = totalguesses + length(prediction3);

for i = 1:length(prediction3)
    if strcmp(truelabel,prediction3(i))
        correctguesses = correctguesses + 1;
    end
end

clear fileread samples kk k eegraw feat
%%
truelabel = {'forwards'};
fileread = rawdata4;                            
samples = number_of_samples:number_of_samples:length(fileread);    %samples means trials indexes

for k = 1:number_of_trials
    feat(k,:) = m11n1feat(rawdata4(:,3:16,k),number_of_samples);
end

currentfeatures = table(feat);
prediction4 = trainedModel.predictFcn(currentfeatures);

totalguesses = totalguesses + length(prediction4);

for i = 1:length(prediction4)
    if strcmp(truelabel,prediction4(i))
        correctguesses = correctguesses + 1;
    end
end

clear fileread samples kk k eegraw feat

accuracy = (correctguesses/totalguesses)*100
