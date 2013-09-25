function Y = eeg_notch(X,fs)
Q = 5; %quality factor 
fo = 60; %fundamental frequency notch filter
wo = fo/(fs/2);  bw = wo/Q; %filter design
[b,a] = iirnotch(wo,bw);
Y = filter(b,a,X); %filtering the signal, for c++ implementation see: http://es.wikipedia.org/wiki/IIR
