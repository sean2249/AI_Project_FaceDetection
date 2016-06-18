rmdir('afraid', 's'); rmdir('angry', 's'); rmdir('disgusted', 's'); 
rmdir('happy', 's'); rmdir('neutral', 's'); 
rmdir('sad', 's'); rmdir('surprised', 's');
%%
folder = dir();
mkdir('afraid'); mkdir('angry'); mkdir('disgusted'); mkdir('happy'); 
mkdir('neutral'); mkdir('sad'); mkdir('surprised');

for i=1:length(folder)
   if (folder(i).isdir==0)
       continue
   end
   files = dir(fullfile(strcat('./',folder(i).name,'/*.jpg')));
   for num=1:length(files)
      fileName = files(num).name;
      if (fileName(7)=='S')
%           xxx = input(fileName);
          label = fileName(5:6);
          path = strcat('./', folder(i).name,'/',files(num).name);
          switch label
              case 'AF'
                  copyfile(path,'./afraid');
              case 'AN'
                  copyfile(path, './angry');
              case 'DI'
                  copyfile(path, './disgusted');
              case 'HA'
                  copyfile(path, './happy');
              case 'NE'
                  copyfile(path, './neutral');
              case 'SA'
                  copyfile(path, './sad');
              case 'SU'
                  copyfile(path, './surprised');
              otherwise
                  fprintf('Wrong file:::%s with %s\n', labelName, path);
          end
      end
   end
end

