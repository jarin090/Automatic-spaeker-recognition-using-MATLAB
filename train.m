function code = train(traindir, n)
% input    code = train('D:\train',7) ekhane train\ na cz sprintf e %s er
% por\deya ase

% Speaker Recognition: Training Stage
%
% Input:
%       traindir : string name/path of directory contains all train sound files
%       n        : number of train files in traindir
%
% Output:
%       code     : trained VQ codebooks, code{i} for i-th speaker
%
% Note:
%       Sound files in traindir is supposed to be: 
%                       s1.wav, s2.wav, ..., sn.wav

k = 16;                         % number of centroids required

for i=1:n                       % train a VQ codebook for each speaker
   %if i~=8 
     file = sprintf('%s\\s%d.wav', traindir, i);           
     %disp(file);
   %else
     %file = sprintf('%s\\s%d.m4a', traindir, i); 
     %disp(file);
   %end
   
    [s, fs] = audioread(file);% fs defult 44100 set hoye jay
    v = jmfcc(s, fs);% Compute MFCC's
   % printf('df');
    
    code{i} = vqCodeBook(v, k);      % Train VQ codebook
end