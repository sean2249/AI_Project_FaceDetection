function [typeLabel, model, cators, musicClip] = initalLabelSetting()
% Default [typelabel, model, cators, musicClip] = 
strMoodLabelFile = 'faceLabel.txt';
strMusicLabelFile = 'musicLabel.txt';
strModelFile = 'HOG_KDEF_model.mat';
strCatorFile = 'HOG_KDEf_cators.mat';
strMusicClipFile = 'songTitle.xls';

if (exist(strMoodLabelFile)==0)
    strMoodLabelFile = input('Enter faceLabel File Name:','s');
end
if (exist(strModelFile)==0)
    strModelFile = input('Enter Model File name: ', 's');
end
if (exist(strCatorFile)==0)
    strCatorFile = input('Enter Cator File name: ', 's');
end
if (exist(strMusicClipFile)==0)
   strMusicClipFile = input('Enter Music Clip name: ', 's'); 
end

strMusicClipFile = 'songTitle.xls';
if (exist(strMusicClipFile)==0)
   strMusicClipFile = input('Enter Music Clip name: ', 's'); 
end

fid=fopen(strMoodLabelFile);
faceLabel=textscan(fid,'%s');
mood = faceLabel{1,1};
fclose(fid); 

fid=fopen(strMusicLabelFile);
musicLabel=textscan(fid, '%s', 'whitespace',',');
music = musicLabel{1,1};
fclose(fid);
typeLabel = {mood,music};

model = load (strModelFile);
model = model.model;

cators = load (strCatorFile);
cators = cators.cators;

[~, musicClipNote, ~] = xlsread(strMusicClipFile);
currentType = cell2mat(musicClipNote(1,1));
typeCnt =1; idx = 1;
for cnt=1:length(musicClipNote)
   if (~ strcmp(cell2mat(musicClipNote(cnt,1)), currentType))
%        musicClip ={musicClip;tmp}; 
       musicClip{1,typeCnt} = (currentType);
       musicClip{2,typeCnt} = ttmp;
       ttmp = {};
       idx = 1; 
       typeCnt = typeCnt + 1;
       currentType = (cell2mat(musicClipNote(cnt,1)));
   else
   end
   ttmp{idx,1} = cell2mat(musicClipNote(cnt,2));
   ttmp{idx,2} = cell2mat(musicClipNote(cnt,3));
   idx = idx +1;
end
musicClip{1,typeCnt} = currentType;
musicClip{2,typeCnt} = ttmp;

end
