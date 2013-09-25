function [X,t,fs,chanLabel] = load_eeg_event(filename,Tc,tm,tp)
% Load segments of a EEG recording.
% USAGE: [X,fs] = load_eeg_event(filename,Tc,tm,tp)
% INPUTS:
%  filename: name of the edf file
%  Tc: time of the event in [HH MM SS]
%  tm: seconds before the event to read
%  tp: seconds after the event to read
% OUTPUTS:
%  X:         multichannel signal of size numberOfTimeInstants x numberOfChannels
%  fs:        sampling frequency
%  chanLabel: Label of each channel on X

HDR=sopen(filename,'r',[2:9 11:18 20:22]); %10-20 electrodes
fs = HDR.SampleRate; %sample rate

ti = HDR.T0(4)*60*60 + HDR.T0(5)*60 + HDR.T0(6); % Initial time in seconds
tc = Tc(1)*60*60 + Tc(2)*60 + Tc(3); %Event time in seconds;
to = tc - ti - tm; %Starting time for reading
[X,HDR] = sread(HDR, tp+tm,to); %read data
t = linspace(tc-tm,tc+tp,size(X,1));
chanLabel = HDR.Label([2:9 11:18 20:22]);

HDR = sclose(HDR);
if (HDR.FILE.status==0)
    display('File closed.')
else
    display('File not closed.')
end