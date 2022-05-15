function test(testdir, n, code)
% Speaker Recognition: Testing Stage
%
% Input:
%       testdir : string name of directory contains all test sound files
%       n       : number of test files in testdir
%       code    : codebooks of all trained speakers
%
% Note:
%       Sound files in testdir is supposed to be: 
%               s1.wav, s2.wav, ..., sn.wav
%
% Example:
%       >> test('C:\data\test\', 8, code);

for k=1:n                       % read test sound file of each speaker
    file = sprintf('%s\\s%d.wav', testdir, k);
    [s, fs] = audioread(file);      
    s=silence_remover(s,fs);   
    v = jmfcc(s, fs);            % Compute MFCC's
   
   % distmin = inf;
    k1 = 0;
    dist=zeros(1,length(code));
   
    for m = 1:length(code)      % each trained codebook, compute distortion
        d = jdistance(v, code{m}); 
        %dist = sum(min(d,[],2)) / size(d,1);
        dist(1,m) = sum(min(d,[],2)) / size(d,1);
      
       %{
        if dist < distmin
            distmin = dist;
            k1 = m;
        end      
    end
        %}
     end
       [distmin,ind]=min(dist);
   %disp(dist);
   k1=ind;
   
    msg = sprintf('Speaker %d matches with speaker %d', k, k1);
    disp(msg);
end