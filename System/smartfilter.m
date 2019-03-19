function y = smartfilter(x)
%Filters the input into a 0.1-64Hz Band.
%ChebII.

persistent SOS G;

if isempty(SOS)
    SOS = [
        
    1.0000   -2.0000    1.0000    1.0000   -1.9875    0.9878
    1.0000    2.0000    1.0000    1.0000    1.9875    0.9878
    1.0000   -2.0000    1.0000    1.0000   -1.9705    0.9708
    1.0000    2.0000    1.0000    1.0000    1.9705    0.9708];

    G =[

    0.9938
    0.9938
    0.9854
    0.9854
    1.0000];

end

s = x - 4100;
y = filtfilt(SOS,G,s);

