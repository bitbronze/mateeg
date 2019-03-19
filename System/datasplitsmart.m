numberofsamples = size(rawdata1,1);
numberoftrials = size(rawdata1,3);

windowsize = 128;
stepsize = 128;

sliderindex = stepsize+1:stepsize:numberofsamples-windowsize+1;
sliderindex = [1 sliderindex];

writemarker = 0;
for i = 1:numberoftrials
    for j = 1:length(sliderindex)
        writemarker = writemarker + 1;
        rawdata11(:,:,writemarker) = rawdata1(sliderindex(j):sliderindex(j)+windowsize-1,:,i);
    end
end

writemarker = 0;
for i = 1:numberoftrials
    for j = 1:length(sliderindex)
        writemarker = writemarker + 1;
        rawdata22(:,:,writemarker) = rawdata2(sliderindex(j):sliderindex(j)+windowsize-1,:,i);
    end
end

writemarker = 0;
for i = 1:numberoftrials
    for j = 1:length(sliderindex)
        writemarker = writemarker + 1;
        rawdata33(:,:,writemarker) = rawdata3(sliderindex(j):sliderindex(j)+windowsize-1,:,i);
    end
end

writemarker = 0;
for i = 1:numberoftrials
    for j = 1:length(sliderindex)
        writemarker = writemarker + 1;
        rawdata44(:,:,writemarker) = rawdata4(sliderindex(j):sliderindex(j)+windowsize-1,:,i);
    end
end

clearvars -except rawdata11 rawdata22 rawdata33 rawdata44 trainedModel cykit;
rawdata1 = rawdata11;
rawdata2 = rawdata22;
rawdata3 = rawdata33;
rawdata4 = rawdata44;
clearvars rawdata11 rawdata22 rawdata33 rawdata44;