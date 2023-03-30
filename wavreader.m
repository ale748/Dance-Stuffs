clear all
close all
clc
fid = fopen('Recording2.wav', 'r');
fid2 = fopen('rec8bit.wav', 'w');
chunkId=fgets(fid,4)
chunksize=fread(fid,1,'uint')
format = fgets(fid,4)
subchunkId=fgets(fid,4);
subchunksize=fread(fid, 1,'uint')
audioformat = fread(fid,1,'ushort')
numchannels = fread(fid,1,'ushort')
samplerate = fread(fid,1,'uint')
samplerate2 = samplerate/2;
byterate = fread(fid,1,'uint')

blockalign = fread(fid,1,'ushort')
bitspersample = fread(fid,1,'ushort')

bytesPerSample = 8;
bitspersample2 = 16;%ceil(bytesPerSample/8)*8;
extraparamsize = fread(fid,1,'ushort')
dataid = fgets(fid,4)
datasize= fread(fid,1,'uint')
numSamples = datasize/(numchannels*(bitspersample/8));
datasize2 = numSamples*numchannels*(bitspersample2/8);
byterate2 = samplerate2*numchannels*bitspersample2/8;
blockalign2 = numchannels*bitspersample2/8;
k=zeros(numSamples,1);
k2=zeros(numSamples,1);
for i=1:numSamples

  k(i)=fread(fid,1,'short');
  k2(i)=bitshift(bitshift(k(i),-(bitspersample-bytesPerSample)),1*(bitspersample-bytesPerSample));

end
fclose(fid)
chunksize2 = 4+8+subchunksize+8+datasize2;

fputs(fid2,chunkId);
fwrite(fid2,chunksize2,'uint');
fputs(fid2,format);
fputs(fid2,subchunkId);
fwrite(fid2,subchunksize,'uint');
fwrite(fid2,audioformat,'ushort');
fwrite(fid2,numchannels,'ushort');
fwrite(fid2,samplerate2,'uint');
fwrite(fid2,byterate2,'uint');
fwrite(fid2,blockalign2,'ushort');
fwrite(fid2,bitspersample2,'ushort');
fwrite(fid2,extraparamsize,'ushort');
fputs(fid2,dataid);
fwrite(fid2,datasize2,'uint');
for i=1:(samplerate/samplerate2):numSamples
  fwrite(fid2,k2(i),'short');
end

fclose(fid2)
plot(k)
figure
plot(k2)
