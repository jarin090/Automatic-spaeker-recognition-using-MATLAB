function c= jmfcc(s, fs)
% MFCC Calculate the mel frequencey cepstrum coefficients (MFCC) of a signal
%
% Inputs:
%       s       : speech signal
%       fs      : sample rate in Hz
%
% Outputs:
%       c       : MFCC output, each column contains the MFCC's for one speech frame
s=silence_remover(s,fs);

N = round(fs*.025);                        % frame size
M = round(fs*.01);                        % inter frame distance
len = length(s);
numberOfFrames = 1 + floor((len - N)/double(M));
mat = zeros(N, numberOfFrames); % vector of frame vectors
a=1;
b=[1, -0.97];       %a and b are high pass filter coefficients



for i=1:numberOfFrames
    index = M*(i-1) + 1;
    for j=1:N
        mat(j,i) = s(index);
        index = index + 1;
    end
    mat(:,i)=filter(b,a,mat(:,i));   %High pass pre-emphasis filter
end

hamW = hamming(N);              % hamming window
afterWinMat = diag(hamW)*mat;   
freqDomMat = fft(afterWinMat,N);  % FFT into freq domain

filterBankMat = mfbank(40,N, fs);                % matrix for a mel-spaced filterbank
nby2 = 1 + floor(N/2);
%nby2=256
ms = filterBankMat*(abs(freqDomMat(1:nby2,:)).^2); % mel spectrum
c = dct(log(ms));                                % mel-frequency cepstrum coefficients
c(1,:) = [];                                    % exclude 0'th order cepstral coefficient
%d = mfcc2delta(c,2);
%{
[f0,idx] = pitch(s,fs,'WindowLength',floor(fs*.025),'OverlapLength',floor(fs*0.015));
f0=f0';
a=[f0;c];
%}
end