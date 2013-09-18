%% Question 1
s1 = 'GGGGAGGTTGCATCATCACAAACATTTCAACTTCGCTGAGTCTCTGGAGGAGACAGT';
s2 = seqrcomplement(s1);
oligoprop(s2)

gcskew=zeros(1,length(s1)-10);
for i=1:length(s1)-10;
    gcskew(i) = (sum(s1(i:i+9)=='G') - sum(s1(i:i+9)=='C'))/...
        (sum(s1(i:i+9)=='G') + sum(s1(i:i+9)=='C'));
end
printsetup()
plot(gcskew)
printfig('pdf', '1b');

basecount(s1)
dimercount(s1)

trimer_start_indices = zeros(1, length(s1)-2);
for i = 1:length(s1)-2;
    trimer_start_indices(strfind(s1, s1(i:i+2))) = 1 +...
        trimer_start_indices(strfind(s1, s1(i:i+2)));
    trimers(i, 1:3) = s1(i:i+2);
end
[C,IA,IC] = unique(trimers, 'rows');


%% Question 2
s1 = dna2rna('ATGCTGGAATATATGTCAGCTGAAACAAAACTTGCG');
s2 = dna2rna('ATGGGAATATATGTCAGCTGAAACAAAACTTGCGCT');
logCAI=0;
for i=1:3:length(s1)
    codon = s1(i:i+2);
    aa = nt2aa(codon);
    for k = 1:length(NTs)
        if(NTs(k,1:3) == codon)
            idx = k;
        end
    end
    logCAI = logCAI + 1/(length(s1)/3)*log(cfreq(idx)/max(cfreq(aa==AAs)));
    cfreq(idx)/max(cfreq(aa==AAs))
end
logCAI1 = logCAI;
logCAI=0;
for i=1:3:length(s2)
    codon = s2(i:i+2);
    aa = nt2aa(codon);
    for k = 1:length(NTs)
        if(NTs(k,1:3) == codon)
            idx = k;
        end
    end
    logCAI = logCAI + 1/(length(s2)/3)*log(cfreq(idx)/max(cfreq(aa==AAs)));
    cfreq(idx)/max(cfreq(aa==AAs))
end
logCAI2 = logCAI;

%% Question 3
% 1st order Markov model
seqa = 'ATGGGAATATATGTCAGCTGAAACAAAACTT';
seqb = 'TAGTCCCGCAATATTGGTTCGGGAAGAAGGA';
transition_probabilities = [
[0.242
0.217
0.246
0.261]'
[0.278
0.222
0.240
0.241]'
[0.253
0.350
0.239
0.255]'
[0.227
0.212
0.275
0.243]'
]';
initial_distribution = [.241 .245 .273 .241];

% now we have a transition matrix
%     A   C   G   T
% A
% C
% G
% T etc.

seq_numeric_a = nt2int(seqa);
seq_numeric_b = nt2int(seqb);
probability_a = initial_distribution(seq_numeric_a(1));
probability_b = initial_distribution(seq_numeric_b(1));
for i=2:length(seq_numeric_a)
    probability_a = probability_a*transition_probabilities(seq_numeric_a(i-1),...
        seq_numeric_a(i));
    probability_b = probability_b*transition_probabilities(seq_numeric_b(i-1),...
        seq_numeric_b(i));    
end
log(probability_a)
log(probability_b)
% Base frequency model
probability_a = initial_distribution(seq_numeric_a(1));
probability_b = initial_distribution(seq_numeric_b(1));
for i=2:length(seq_numeric_a)
probability_a = probability_a*initial_distribution(seq_numeric_a(i));
probability_b = probability_b*initial_distribution(seq_numeric_b(i));
end
log(probability_a)
log(probability_b)
%% Question 4
kmer1 = 'C';
kmer2 = 'AAA';
kmer3 = 'CGCG';
kmer4 = 'TACG';
kmer5 = 'GGG';
kmer6 = 'TATATA';
freqs = [0.3
0.01
0.001
0.005
0.01
0.001];


prs(1) = prod(initial_distribution(nt2int(kmer1)));
prs(2) = prod(initial_distribution(nt2int(kmer2)));
prs(3) = prod(initial_distribution(nt2int(kmer3)));
prs(4) = prod(initial_distribution(nt2int(kmer4)));
prs(5) = prod(initial_distribution(nt2int(kmer5)));
prs(6) = prod(initial_distribution(nt2int(kmer6)));
%%
cfreq = [0.3
0.24
0.47
0.23
0.4
0.11
0.27
0.54
0.46
0.54
0.46
0.42
0.58
0.54
0.46
0.25
0.34
0.25
0.16
0.58
0.42
0.17
0.47
0.36
0.43
0.57
0.07
0.2
0.4
0.13
0.08
0.13
1
0.53
0.47
0.28
0.32
0.11
0.29
0.27
0.73
0.21
0.21
0.11
0.18
0.2
0.08
0.24
0.15
0.15
0.22
0.05
0.19
0.28
0.36
0.11
0.25
0.12
0.24
0.46
0.18
1
0.56
0.44]
NTs = ['UAA'
'UAG'
'UGA'
'GCA'
'GCC'
'GCG'
'GCU'
'UGC'
'UGU'
'GAC'
'GAU'
'GAA'
'GAG'
'UUC'
'UUU'
'GGA'
'GGC'
'GGG'
'GGU'
'CAC'
'CAU'
'AUA'
'AUC'
'AUU'
'AAA'
'AAG'
'CUA'
'CUC'
'CUG'
'CUU'
'UUA'
'UUG'
'AUG'
'AAC'
'AAU'
'CCA'
'CCC'
'CCG'
'CCU'
'CAA'
'CAG'
'AGA'
'AGG'
'CGA'
'CGC'
'CGG'
'CGU'
'AGC'
'AGU'
'UCA'
'UCC'
'UCG'
'UCU'
'ACA'
'ACC'
'ACG'
'ACU'
'GUA'
'GUC'
'GUG'
'GUU'
'UGG'
'UAC'
'UAU']

AAs= ['*'
'*'
'*'
'A'
'A'
'A'
'A'
'C'
'C'
'D'
'D'
'E'
'E'
'F'
'F'
'G'
'G'
'G'
'G'
'H'
'H'
'I'
'I'
'I'
'K'
'K'
'L'
'L'
'L'
'L'
'L'
'L'
'M'
'N'
'N'
'P'
'P'
'P'
'P'
'Q'
'Q'
'R'
'R'
'R'
'R'
'R'
'R'
'S'
'S'
'S'
'S'
'S'
'S'
'T'
'T'
'T'
'T'
'V'
'V'
'V'
'V'
'W'
'Y'
'Y']
