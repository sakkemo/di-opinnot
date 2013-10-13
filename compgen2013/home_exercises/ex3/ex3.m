%% Question 1
s = 'AGTCTACG';
p = 'GGTGCTCG';

%% Question 2
reference = 'TCGCACGAACGCCCGA';
reads = ['TCGT'; 'ATGT'; 'TCGA'];

for i=1:3
[score, align] = swalign(reads(i,:), reference, 'alphabet', 'nt')
end

for i=1:3
    reads(i,:)
[score, align] = swalign(reads(i,:), strrep(reference, 'C', 'Y'),...
    'alphabet', 'nt')
end

for i=1:3
    reads(i,:)
    [score, align] = swalign(strrep(reads(i,:), 'C', 'T'),...
        strrep(reference, 'C', 'T'), 'alphabet', 'nt')
end
