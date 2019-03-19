for k=1:size(rawdata1,3)
diff1(:,k)  = diff(rawdata1(:,1,k));
end

for j = 1:size(diff1,2)
    for i = 1:size(diff1,1)
        if diff1(i,j) == 1 || diff1(i,j) == -127
        else
            fprintf('Corrupt Data, Samples Missing, rawdata1, %i,%i\n',i,j);
        end
    end
end


for k=1:size(rawdata2,3)
diff2(:,k)  = diff(rawdata2(:,1,k));
end

for j = 1:size(diff2,2)
    for i = 1:size(diff2,1)
        if diff2(i,j) == 1 || diff2(i,j) == -127
        else
           fprintf('Corrupt Data, Samples Missing, rawdata2, %i,%i\n',i,j);
        end
    end
end

for k=1:size(rawdata3,3)
diff3(:,k)  = diff(rawdata3(:,1,k));
end

for j = 1:size(diff3,2)
    for i = 1:size(diff3,1)
        if diff3(i,j) == 1 || diff3(i,j) == -127
        else
           fprintf('Corrupt Data, Samples Missing, rawdata3, %i,%i\n',i,j);
        end
    end
end

for k=1:size(rawdata4,3)
diff4(:,k)  = diff(rawdata4(:,1,k));
end

for j = 1:size(diff4,2)
    for i = 1:size(diff4,1)
        if diff4(i,j) == 1 || diff4(i,j) == -127
        else
            fprintf('Corrupt Data, Samples Missing, rawdata4, %i,%i\n',i,j);
        end
    end
end
