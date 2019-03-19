clearvars -except trainedModel cykit;
number_of_samples = 128; %the model was trained on
n=0; 
while n < 20 %number of times to run
eegraw = getsamplesfromheadset(number_of_samples,cykit);

feat = m11n1feat(eegraw,number_of_samples);
currentfeatures = table(feat);

prediction = trainedModel.predictFcn(currentfeatures);
prediction_text = cell2mat(prediction);

robotcontrolfunction(prediction_text);
fprintf('%i: %s\n',n,prediction_text);

n=n+1;
end

robotcontrolfunction('end');