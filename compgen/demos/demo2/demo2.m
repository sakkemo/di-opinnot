%% The percentage used was appended to the name, giving BLOSUM80 
% for example where sequences that were more than 80% identical
% were clustered.
bl62 = blosum(62)
bl75 = blosum(75)
bl100 = blosum(100)

pam10 = pam(10)
pam30 = pam(30)
pam100 = pam(100)

%% Aligning sequences
rat_myosin = 'kakkaitdaammaeelkkeqdtsahlermkknmeqtvkdlqlrldeaeqlalkggkkqiqklearvrelegeveseqkrnveavkglrkherrvkeltyqteedrknilrlqdlvdklqakvksykrqaeeaeeqsntnlskfrklqheleeaeeradiaesqvnklrvksrevhtkvisee';
human_myosin = 'elldaservqllhtqntslintkkkletdisqmqgemedilqearnaeekakkaitdaammaeelkkeqdtsahlermkknmeqtvkdlqlrldeaeqlalkggkkqiqklearvrelegeveseqkrnaeavkglrkherrvkeltyqteedrknilrlqdlvdklqakvksykrqaeeaeeqsntnlakfrklqheleeaeeradiaesqvnklrvksrevhtkvisee';

align1 = localalign(rat_myosin, human_myosin);
align1
align1.Score
align1.Alignment{1}

align2 = localalign(rat_myosin, human_myosin,'numaln',10);
align2

for i=1:10
    showalignment(align2.Alignment{i})
end

%% 

s1 = 'ARQWERWDIKLPP';
s2 = 'FQWVCXLPKASRT';
[score, alignment] = nwalign(s1,s2);

s_length = length(s1);
numb_above=0;

for i=1:1000
    k=randperm(s_length);
    score1=nwalign(s1(k), s2);
    if score1>score
        numb_above = numb_above + 1;
    end
end

numb_above/1000