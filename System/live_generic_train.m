%please note that we are using 3:16 for error tracking purposes
clearvars -except cykit

%add paths to python interpreter, initialize python module
if length(py.sys.path) == 6
    root_path = 'C:\Users\Maydor\Desktop\CyKITv2-masterMIO_CLEAN_PYTHON_371\CyKITv2-masterMIO\Python\';
    insert(py.sys.path,int32(0),root_path);
    insert(py.sys.path,int32(0),[root_path 'cyUSB']);
    cykit = py.eeg.EEG;
end

number_of_samples = 640; %user variables
number_of_trials = 2;    %user variables

subjname = 'Osama';

class1 = {'null'};
class2 = {'right'};
class3 = {'left'};
class4 = {'forwards'};

%%
beep; msg = msgbox(sprintf('Get ready for training "%s" class',cell2mat(class1)));
pause(5);
close(msg);

tic();
for k = 1:number_of_trials
    beep; msg = msgbox(sprintf('%s: trial #%i',cell2mat(class1),k));
    eegraw = getsamplesfromheadset(number_of_samples,cykit);
    feat(k,:) = m1n1feat(eegraw(:,3:16),number_of_samples);
    close(msg);
    beep; msg = msgbox('Relax and get ready again');
    pause(5);
    close(msg);
    rawdata1(:,:,k) = eegraw;
end

class1features = table(feat, repmat(class1,k,1));
toc();
%%
beep; msg = msgbox(sprintf('Get ready for training "%s" class',cell2mat(class2)));
pause(5);
close(msg);

tic();
for k = 1:number_of_trials
    beep; msg = msgbox(sprintf('%s: trial #%i',cell2mat(class2),k));
    eegraw = getsamplesfromheadset(number_of_samples,cykit);
    feat(k,:) = m1n1feat(eegraw(:,3:16),number_of_samples);
    close(msg);
    beep; msg = msgbox('Relax and get ready again');
    pause(5);
    close(msg);
    rawdata2(:,:,k) = eegraw;
end

class2features = table(feat, repmat(class2,k,1));
toc();
%%
beep; msg = msgbox(sprintf('Get ready for training "%s" class',cell2mat(class3)));
pause(5);
close(msg);

tic();
for k = 1:number_of_trials
    beep; msg = msgbox(sprintf('%s: trial #%i',cell2mat(class3),k));
    eegraw = getsamplesfromheadset(number_of_samples,cykit);
    feat(k,:) = m1n1feat(eegraw(:,3:16),number_of_samples);
    close(msg);
    beep; msg = msgbox('Relax and get ready again');
    pause(5);
    close(msg);
    rawdata3(:,:,k) = eegraw;
end

class3features = table(feat, repmat(class3,k,1));
toc();
%%
beep; msg = msgbox(sprintf('Get ready for training "%s" class',cell2mat(class4)));
pause(5);
close(msg);

tic();
for k = 1:number_of_trials
    beep; msg = msgbox(sprintf('%s: trial #%i',cell2mat(class4),k));
    eegraw = getsamplesfromheadset(number_of_samples,cykit);
    feat(k,:) = m1n1feat(eegraw(:,3:16),number_of_samples);
    close(msg);
    beep; msg = msgbox('Relax and get ready again');
    pause(5);
    close(msg);
    rawdata4(:,:,k) = eegraw;
end

class4features = table(feat, repmat(class4,k,1));
toc();
%%
save(sprintf('%s_%s',subjname,datestr(now,'dd-mm-yy_HH-MM-SS')),'rawdata*');
allfeatures = outerjoin(outerjoin(outerjoin(class1features,class2features,'MergeKeys', true),class3features,'MergeKeys', true),class4features,'MergeKeys', true);