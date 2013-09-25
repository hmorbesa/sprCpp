
filename = 'C:\Users\dcardenasp\Documents\DataBases\edf\HOYOSCHAVEZ~ A_02942669-14ea-4c45-af13-f39a3ef2cc47.edf';

Tc = [06 02 39]; %Crisis time
tm = 10;% read 10 secs before the crisis
tp = 20;% read 20 secs after the crisis
[Y,t,fs,chanLabel] = load_eeg_event(filename,Tc,tm,tp);

Yf = eeg_notch(Y,fs); %60Hz filtering
bias = mean(Yf,1); %zero-mean normalization
Yb = Yf - repmat(bias,size(Yf,1),1);

ref = mean(Yb,2); %Averaging reference
Y = Yb-repmat(ref,[1 size(Yb,2)]); %Averaging montage

plot(t,Y)
xlabel('Time [s]')
legend(chanLabel)

save AH_eeg.mat Y fs chanLabel