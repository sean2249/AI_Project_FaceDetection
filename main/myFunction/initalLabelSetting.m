function [typeLabel,mood, allModel, musicClip] = initalLabelSetting(prm)
% Default [typelabel, model, cators, musicClip] = 
strMoodLabelFile = 'faceLabel.txt';
strMusicLabelFile = 'musicLabel.txt';
strMusicClipFile = 'songTitle2.xls';


% keyboard;

if ~exist(prm.modelName)
    if ~exist(prm.saveFeatureName)
        featureExtraction(prm);
    end
    allModel = trainModel(prm);
else
   load(prm.modelName); 
end
if ~exist(strMoodLabelFile)
    strMoodLabelFile = input('Enter faceLabel File Name:','s');
end
if ~exist(strMusicClipFile)
   strMusicClipFile = input('Enter Music Clip name: ', 's'); 
end

% strMusicClipFile = 'songTitle.xls';
if ~exist(strMusicClipFile)
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

[~, musicClipNote, ~] = xlsread(strMusicClipFile);
currentType = cell2mat(musicClipNote(1,1));
typeCnt =1; idx = 1;
for cnt=1:length(musicClipNote)
   if (~ strcmp(cell2mat(musicClipNote(cnt,1)), currentType))
       musicClip{1,typeCnt} = (currentType);
       musicClip{2,typeCnt} = ttmp;
       ttmp = {};
       idx = 1; 
       typeCnt = typeCnt + 1;
       currentType = (cell2mat(musicClipNote(cnt,1)));
   end
   ttmp{idx,1} = cell2mat(musicClipNote(cnt,2));
   ttmp{idx,2} = cell2mat(musicClipNote(cnt,3));
   idx = idx +1;
end
musicClip{1,typeCnt} = currentType;
musicClip{2,typeCnt} = ttmp;

end
