% #!/usr/bin/octave -qf


% argvlist=argv();
% range_matrix_mult(argvlist{1,1}, argvlist{2,1});


function [] =  range_matrix_mult(m,M)
    % m=1;
    % M=1000;
    for i = m : M
        matrix_multiplier(i);
    end
end




function [] = matrix_multiplier(M)

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

    tmp = CircularizeMatrix(G_M');

    % write P data
    FileName = strcat('./p/',int2str(M), '.txt');
    WriteMatrixToFileNewlinePerElement(FileName,'wt',G_M');

    % write G dimensions and its data
    FileName = strcat('./g/',int2str(M), '.txt');
    s_m = size(G_M,1);
    fid = fopen(FileName, 'wt');
    fprintf(fid,'%d\n',s_m);
    fprintf(fid,'%d\n',s_m);
    fclose(fid);
    WriteMatrixToFileNewlinePerElement(FileName,'a',G_M');

    %file pointer of results
    file_pointer =  strcat('./r/',int2str(M), '.txt');
    fid = fopen(file_pointer, 'wt'); % Open file and write the original matrix to the file.


    WriteMatrixToFileNormal(file_pointer,tmp); % note this function will close the file
    txt=sprintf('RESULT of Initial Data\n');
    dlmwrite(file_pointer, txt,'-append','delimiter', '','roffset',0);


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
    WriteMatrixToFileNormal(file_pointer,tmp);
    txt=sprintf('RESULT of P*G\n');
    dlmwrite(file_pointer, txt,'-append','delimiter', '','roffset',0);

    Res = Res * G_M;
    Res = CircularizeMatrix(Res);
    WriteMatrixToFileNormal(file_pointer,Res);
    txt=sprintf('RESULT of PG*G\n');
    dlmwrite(file_pointer, txt,'-append','delimiter', '','roffset',0);



    %%%%%%%%%%%%%%%%%%%%% P*Gt %%%%%%%%%%%%%%%%%%%%%%%%%%%
    Res = G_M * G_M';
    tmp = CircularizeMatrix(Res);
    WriteMatrixToFileNormal(file_pointer,tmp);
    txt=sprintf('RESULT of P*Gt\n');
    dlmwrite(file_pointer, txt,'-append','delimiter', '','roffset',0);

    Res = Res * G_M';
    Res = CircularizeMatrix(Res);
    WriteMatrixToFileNormal(file_pointer,Res);
    txt=sprintf('RESULT of PGt*Gt\n');
    dlmwrite(file_pointer, txt,'-append','delimiter', '','roffset',0);


    %%%%%%%%%%%%%%%%%%%%% Pt*G %%%%%%%%%%%%%%%%%%%%%%%%%%%
    Res = G_M' * G_M;
    tmp = CircularizeMatrix(Res);
    WriteMatrixToFileNormal(file_pointer,tmp);
    txt=sprintf('RESULT of Pt*G\n');
    dlmwrite(file_pointer, txt,'-append','delimiter', '','roffset',0);

    Res = Res' * G_M;
    Res = CircularizeMatrix(Res);
    WriteMatrixToFileNormal(file_pointer,Res);
    txt=sprintf('RESULT of PtG*G\n');
    dlmwrite(file_pointer, txt,'-append','delimiter', '','roffset',0);


    %%%%%%%%%%%%%%%%%%%%% Pt*Gt %%%%%%%%%%%%%%%%%%%%%%%%%%%
    Res = G_M' * G_M';
    tmp = CircularizeMatrix(Res);
    WriteMatrixToFileNormal(file_pointer,tmp);
    txt=sprintf('RESULT of Pt*Gt\n');
    dlmwrite(file_pointer, txt,'-append','delimiter', '','roffset',0);

    Res = Res' * G_M';
    Res = CircularizeMatrix(Res);
    WriteMatrixToFileNormal(file_pointer,Res);
    txt=sprintf('RESULT of PtGt*Gt\n');
    dlmwrite(file_pointer, txt,'-append','delimiter', '','roffset',0);

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
