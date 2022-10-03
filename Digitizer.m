% Script for manual digitization of WA5FRF's data.
% Written by KD8OXT, October 2022. 

% Note: This script uses MATLAB's getpts function, which is considered
% deprecated - it probably won't work with versions of MATLAB newer than
% R2020a, which is what I used here. However, I still haven't found an
% OpenCV alternative - or even a current MATLAB class - that works as well.

% clear all close all clc
clearvars T
% TODO: Import .mat file.

filename = 'multipath2020_10_03';
I = eval(filename); % (quick and dirty)
im = imadjust(I,[0.3 0.7],[]);%stretchlim(I),[]);


% Set bounds of cropped image:
minfreq = 995;  % The leftmost edge of the image corresponds to 995 Hz
maxfreq = 1005; % The rightmost edge corresponds to 1005 Hz

mintime = 12; % Bottom of figure, in hours UTC
maxtime = 14; % Top of figure, in hours UTC

traces = {'1E','2E', '1F', '2F', '3F'};

for tracenum = 1:length(traces) 
    trace = traces{tracenum} 
    fig = imshow(im)
    ax = gca
    title(strcat("Select all points in the ", trace, ' trace. Double-click to exit.'))
    [xi,yi] = getpts
    

    for i = 1:length(xi)
        time = -yi(i)/size(im, 1) * (maxtime-mintime) + maxtime % arrow of time is flipped
        freq = maxfreq - xi(i)/size(im, 2) * (maxfreq-minfreq) 
        C = {trace,time,freq};
        T1 = cell2table(C,'VariableNames',{'Mode','Time UTC','Freq Hz'})
        if ~exist('T')
            T = T1;
        else
            T = [T; T1];
        end

    end
    
end

writetable(T, strcat(filename, '.csv'))
