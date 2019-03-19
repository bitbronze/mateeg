clearvars -except cykit rawdata*

number_of_samples = size(rawdata1,1); %user variables
number_of_trials = size(rawdata1,3);    %user variables

class1 = {'null'};
class2 = {'right'};
class3 = {'left'};
class4 = {'forwards'};
%%
tic();
for k = 1:number_of_trials
    feat(k,:) = m11n1feat(rawdata1(:,3:16,k),number_of_samples);
end
class1features = table(feat, repmat(class1,k,1));
toc();
%%
tic();
for k = 1:number_of_trials
    feat(k,:) = m11n1feat(rawdata2(:,3:16,k),number_of_samples);
end
class2features = table(feat, repmat(class2,k,1));
toc();
%%
tic();
for k = 1:number_of_trials
    feat(k,:) = m11n1feat(rawdata3(:,3:16,k),number_of_samples);
end
class3features = table(feat, repmat(class3,k,1));
toc();
%%
tic();
for k = 1:number_of_trials
    feat(k,:) = m11n1feat(rawdata4(:,3:16,k),number_of_samples);
end
class4features = table(feat, repmat(class4,k,1));
toc();
%%
allfeatures = outerjoin(outerjoin(outerjoin(class1features,class2features,'MergeKeys', true),class3features,'MergeKeys', true),class4features,'MergeKeys', true);