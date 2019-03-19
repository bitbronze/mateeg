%generic method is m3n1feat
clear
number_of_samples = 640; %Specify here before running

class1 = {'null'};
class1file = 'mltest5_null.csv';
class2 = {'right'};
class2file = 'mltest5_right.csv';
class3 = {'left'};
class3file = 'mltest5_left.csv';
class4 = {'forwards'};
class4file = 'mltest5_forwards.csv';

%%
fileread = getsamplesfromfile(class1file);                            
samples = number_of_samples:number_of_samples:length(fileread);    %samples means trials indexes

for kk = 1:length(samples)
    k = samples(kk);
    eegraw = fileread(k-number_of_samples+1:k,:);
    feat(kk,:) = m3n1feat(eegraw,number_of_samples);
end

class1features = table(feat, repmat(class1,kk,1));

clear fileread samples kk k eegraw feat

%%
fileread = getsamplesfromfile(class2file);                            
samples = number_of_samples:number_of_samples:length(fileread);    %samples means trials indexes

for kk = 1:length(samples)
    k = samples(kk);
    eegraw = fileread(k-number_of_samples+1:k,:);
    feat(kk,:) = m3n1feat(eegraw,number_of_samples);
end

class2features = table(feat, repmat(class2,kk,1));

clear fileread samples kk k eegraw feat

%%
fileread = getsamplesfromfile(class3file);                            
samples = number_of_samples:number_of_samples:length(fileread);    %samples means trials indexes

for kk = 1:length(samples)
    k = samples(kk);
    eegraw = fileread(k-number_of_samples+1:k,:);
    feat(kk,:) = m3n1feat(eegraw,number_of_samples);
end

class3features = table(feat, repmat(class3,kk,1));

clear fileread samples kk k eegraw feat

%%
fileread = getsamplesfromfile(class4file);                            
samples = number_of_samples:number_of_samples:length(fileread);    %samples means trials indexes

for kk = 1:length(samples)
    k = samples(kk);
    eegraw = fileread(k-number_of_samples+1:k,:);
    feat(kk,:) = m3n1feat(eegraw,number_of_samples);
end

class4features = table(feat, repmat(class4,kk,1));

clear fileread samples kk k eegraw feat

%%
allfeatures = outerjoin(outerjoin(outerjoin(class1features,class2features,'MergeKeys', true),class3features,'MergeKeys', true),class4features,'MergeKeys', true);
