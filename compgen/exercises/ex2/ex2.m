%% Question 1
[score, ali] = swalign('NSRTYI','NFRTWI','scoringmatrix','blosum62')
aas = 'NSRTYI'
aaint = aa2int(aas)
aas2 = 'NFRTWI'
aaint2 = aa2int(aas2)
m = blosum62();
score = 0
for i=1:length(aas)
    score = score + m(aaint(i),aaint2(i))
end
score=score/2;

bitscore = (0.31*score-log(0.038))/log(2)
E = 0.038 * 5134782 * 30 * exp(-0.31*10)

%% Question 2
aas = 'RKGA'
aaint = aa2int(aas)
m = blosum62();
scores = zeros(4)
for i=1:length(aas)
    for j=1:length(aas)
        scores(i,j) = m(aaint(i),aaint(j))
    end
end

aas2 = 'VILM'
aaint2 = aa2int(aas2)
m = blosum62();
scores = zeros(4)
for i=1:length(aas)
    for j=1:length(aas2)
        scores(i,j) = m(aaint(i),aaint2(j))
    end
end

%% Question 4
[score, alignment] = ex2_pr4('ATQWERI','ATQDSRI',blosum62(),-1)
