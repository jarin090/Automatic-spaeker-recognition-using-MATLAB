function silencer=silence_remover(s,fs)
signal_with_silence=s;
frame_duration=0.01;
frame_len = frame_duration*fs;
N=length(signal_with_silence);
num_frames=floor(N/frame_len);
new_sig=zeros(N,1);
count=0;
%Creating Frames using for loop
for k = 1 : num_frames
    frame = signal_with_silence((k-1)*frame_len+1 : frame_len*k);
    max_val = max(frame);
    
    if (max_val>0.01)
        count = count + 1;
        new_sig((count-1)*frame_len+1 : frame_len*count) = frame;
    end
end
%Removing the ending zeros from signal without silence
signal_without_silence=new_sig(new_sig~=0);
silencer=signal_without_silence;
