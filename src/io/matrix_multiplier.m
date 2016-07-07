function [] = matrix_multiplier(M)
file_pointer = 'PG_Result_Matlab.txt';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This session Generates a sqaure matrix of the form 1, 2, 3 . . .to N.
% Then displays it as a circulant matrix. but the matrix itself is not
% saved as circulant.
temp = repmat(M,1,M);
for i=1: M  
  if i == 1
    temp2 = [1:M];
    G_M(:,i) = 1:M;
  else
      temp2 = temp2 + temp;
      G_M(:,i) = temp2;
  end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% tmp = CircularizeMatrix(G_M');
% txt=sprintf('Initial Data');
% dlmwrite(file_pointer, txt,'delimiter', ' ');
% dlmwrite(file_pointer,tmp,'-append','delimiter','\t','roffset',1);

 tmp = CircularizeMatrix(G_M');
 
 fid = fopen(file_pointer, 'wt'); % Open file and write the original matrix to the file.
 fprintf(fid, 'Initial Data');
 WriteMatrixToFileNormal(file_pointer,tmp); % note this function will close the file
 

FileName = '../TestingFiles/Pdata.txt';

%WriteMatrixToFileNormal(FileName, G_M');% Pass the matrix and write it to the file;
WriteMatrixToFileNewlinePerElement(FileName,'wt',G_M');

FileName = '../TestingFiles/Gdata.txt';
s_m = size(G_M,1);
fid = fopen(FileName, 'wt');
fprintf(fid,'%d\n',s_m);
fprintf(fid,'%d\n',s_m);
fclose(fid);
WriteMatrixToFileNewlinePerElement(FileName,'a',G_M');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Transpose the matrix to be in format like
%   1  2   3    4 instead of -> 1  5  9  13
%   5  6   7    8               2  6  10 14
%   9  10  11  12               3  7  11 15
%   13 14  15  16               4  8  12 16

G_M = G_M';


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Start precalcualtion of Matrix Result.
%
%%%%%%%%%%%%%%%%%%%%% P*G %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Res = G_M * G_M;    
tmp = CircularizeMatrix(Res);

txt=sprintf('P*G');

dlmwrite(file_pointer, txt,'-append','delimiter', ' ','roffset',1);

%dlmwrite(file_pointer,tmp,'-append','delimiter',' ','precision',10,'roffset',1);

WriteMatrixToFileNormal(file_pointer,tmp);

Res = Res * G_M;

Res = CircularizeMatrix(Res);
%dlmwrite(file_pointer,Res,'-append','delimiter',' ','precision',10,'roffset',1);
WriteMatrixToFileNormal(file_pointer,Res);
%%%%%%%%%%%%%%%%%%%%% P*Gt %%%%%%%%%%%%%%%%%%%%%%%%%%%
Res = G_M * G_M';    
tmp = CircularizeMatrix(Res);

txt=sprintf('P*Gt');

dlmwrite(file_pointer, txt,'-append','delimiter', ' ','roffset',1);

%dlmwrite(file_pointer,tmp,'-append','delimiter',' ','precision',10,'roffset',1);
WriteMatrixToFileNormal(file_pointer,tmp);

Res = Res * G_M';

Res = CircularizeMatrix(Res);
%dlmwrite(file_pointer,Res,'-append','delimiter',' ','precision',10,'roffset',1);
WriteMatrixToFileNormal(file_pointer,Res);
%%%%%%%%%%%%%%%%%%%%% Pt*G %%%%%%%%%%%%%%%%%%%%%%%%%%%
Res = G_M' * G_M;    
tmp = CircularizeMatrix(Res);

txt=sprintf('Pt*G');

dlmwrite(file_pointer, txt,'-append','delimiter', ' ','roffset',1);

%dlmwrite(file_pointer,tmp,'-append','delimiter',' ','precision',10,'roffset',1);
WriteMatrixToFileNormal(file_pointer,tmp);
Res = Res' * G_M;

Res = CircularizeMatrix(Res);
%dlmwrite(file_pointer,Res,'-append','delimiter',' ','precision',10,'roffset',1);
WriteMatrixToFileNormal(file_pointer,Res);
%%%%%%%%%%%%%%%%%%%%% Pt*Gt %%%%%%%%%%%%%%%%%%%%%%%%%%%
Res = G_M' * G_M';    
tmp = CircularizeMatrix(Res);

txt=sprintf('Pt*Gt');

dlmwrite(file_pointer, txt,'-append','delimiter', ' ','roffset',1);

%dlmwrite(file_pointer,tmp,'-append','delimiter',' ','precision',10,'roffset',1);
WriteMatrixToFileNormal(file_pointer,tmp);
Res = Res' * G_M';

Res = CircularizeMatrix(Res);
%dlmwrite(file_pointer,Res,'-append','delimiter',' ','precision',10,'roffset',1);
WriteMatrixToFileNormal(file_pointer,Res);
end

function value =  CircularizeMatrix(Matrix)

    for i= 1: size(Matrix,1)
        temp = Matrix(i,:);
        temp = temp';
    if i > 1;
        temp = circshift(temp,i-1);
    end;
    value(i,:) = temp;
    %Res(i,:)=Res(randperm(size(Res,2)),i);
    end
end



function [] = WriteMatrixToFileNormal(FileName,M)
 fid = fopen(FileName, 'a'); % Open for appending.
 fprintf(fid, '\n');
 x = size(M,1);
for i=1:x 
   fprintf(fid, '%-10d', M(i,:)); 
   fprintf(fid, '\n');
   
end
fclose(fid);
end

function [] = WriteMatrixToFileNewlinePerElement(FileName,mode, M)
 fid = fopen(FileName, mode); % Open for writing
for j=1:size(M,1)
    for i=1: size(M,2)
        fprintf(fid, '%d ', M(j,i));
        fprintf(fid, '\n');
    end
end
fclose(fid);

end
