function [score alignment] = ex2_pr4(seqA, seqB, scm, penalty)
%EX2_PR4 Summary of this function goes here
%   Detailed explanation goes here
s1 = aa2int(seqA);
s2 = aa2int(seqB);
lengthA = length(seqA);
lengthB = length(seqB);
DPmatrix = zeros(lengthA+1, lengthB+1);
pointer = zeros(lengthA+1, lengthB+1);
max_score = 0;

for i=2:lengthA+1
    for j=2:lengthB+1
        score_diag = DPmatrix(i-1,j-1) + scm(s1(i-1),s2(j-1));
        score_up = DPmatrix(i,j-1) + penalty;
        score_left = DPmatrix(i-1,j) + penalty;
        DPmatrix(i,j)=max([0,score_diag,score_up,score_left]);
        if(DPmatrix(i,j)==0)
            pointer(i,j)=0;
        end
        if(DPmatrix(i,j)==score_left)
            pointer(i,j)=1;
        end
        if(DPmatrix(i,j)==score_up)
            pointer(i,j)=2;
        end
        if(DPmatrix(i,j)==score_diag)
            pointer(i,j)=3;
        end
        if(DPmatrix(i,j)>=max_score)
            max_i=i;
            max_j=j;
            max_score = DPmatrix(i,j);
        end
    end
end
ali1=''; ali2='';
i = max_i; j = max_j;

while pointer(i,j)~=0
    if(pointer(i,j)==3)
        ali1 = strcat(ali1, seqA(i-1));
        ali2 = strcat(ali2, seqB(j-1));
        i = i-1;
        j = j-1;
    elseif(pointer(i,j)==2)
        ali1 = strcat(ali1,'-');
        ali2 = strcat(ali2,seqB(j-1));
        j = j-1;
    elseif(pointer(i,j)==1)
        ali1 = strcat(ali1, seqA(i-1));
        ali2 = strcat(ali2, '-');
        i = i-1;
    end
end

ali1 = fliplr(ali1); ali2 = fliplr(ali2);
i=0; j=0;
score=0;

for i=1:length(ali1)
    if(ali1(i)=='-' || ali2(i)=='-')
        score = score + penalty;
    else
        score = score + scm(aa2int(ali1(i)),aa2int(ali2(i)));
    end
end
score=score/2;

alignment(1,1:length(ali1))=ali1;
alignment(2,1:length(ali2))=ali2;

end

