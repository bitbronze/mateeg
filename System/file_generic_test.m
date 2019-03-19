%m3n1feat
clearvars -except trainedModel allfeatures;
number_of_samples = 640; %change and specify
totalguesses = 0;
correctguesses = 0;
%%
truelabel = {'null'};
fileread = getsamplesfromfile('mltest5_null_test.csv');                            
samples = number_of_samples:number_of_samples:length(fileread);    %samples means trials indexes

for kk = 1:length(samples)
    k = samples(kk);
    eegraw = fileread(k-number_of_samples+1:k,:);
    feat(kk,:) = m3n1feat(eegraw,number_of_samples);
end

currentfeatures = table(feat);
prediction = trainedModel.predictFcn(currentfeatures);

totalguesses = totalguesses + length(prediction);

for i = 1:length(prediction)
    if strcmp(truelabel,prediction(i))
        correctguesses = correctguesses + 1;
    end
end

clear fileread samples kk k eegraw feat prediction
%%
truelabel = {'right'};
fileread = getsamplesfromfile('mltest5_right_test.csv');                            
samples = number_of_samples:number_of_samples:length(fileread);    %samples means trials indexes

for kk = 1:length(samples)
    k = samples(kk);
    eegraw = fileread(k-number_of_samples+1:k,:);
    feat(kk,:) = m3n1feat(eegraw,number_of_samples);
end

currentfeatures = table(feat);
prediction = trainedModel.predictFcn(currentfeatures);

totalguesses = totalguesses + length(prediction);

for i = 1:length(prediction)
    if strcmp(truelabel,prediction(i))
        correctguesses = correctguesses + 1;
    end
end

clear fileread samples kk k eegraw feat prediction
%%
truelabel = {'left'};
fileread = getsamplesfromfile('mltest5_left_test.csv');                            
samples = number_of_samples:number_of_samples:length(fileread);    %samples means trials indexes

for kk = 1:length(samples)
    k = samples(kk);
    eegraw = fileread(k-number_of_samples+1:k,:);
    feat(kk,:) = m3n1feat(eegraw,number_of_samples);
end

currentfeatures = table(feat);
prediction = trainedModel.predictFcn(currentfeatures);

totalguesses = totalguesses + length(prediction);

for i = 1:length(prediction)
    if strcmp(truelabel,prediction(i))
        correctguesses = correctguesses + 1;
    end
end

clear fileread samples kk k eegraw feat prediction
%%
truelabel = {'forwards'};
fileread = getsamplesfromfile('mltest5_forwards_test.csv');                            
samples = number_of_samples:number_of_samples:length(fileread);    %samples means trials indexes

for kk = 1:length(samples)
    k = samples(kk);
    eegraw = fileread(k-number_of_samples+1:k,:);
    feat(kk,:) = m3n1feat(eegraw,number_of_samples);
end

currentfeatures = table(feat);
prediction = trainedModel.predictFcn(currentfeatures);

totalguesses = totalguesses + length(prediction);

for i = 1:length(prediction)
    if strcmp(truelabel,prediction(i))
        correctguesses = correctguesses + 1;
    end
end

clear fileread samples kk k eegraw feat prediction

accuracy = (correctguesses/totalguesses)*100
