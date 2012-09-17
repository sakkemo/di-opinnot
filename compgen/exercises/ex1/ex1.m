%% Question 1
HC22 = getgenbank('NT_011526', 'SequenceOnly', true);
fprintf('Length: %d\n',length(HC22))
fprintf('Ratio of chromosome 22: %.2f %%\n',length(HC22)/51304566*100)

% Most abundant nucleotide and dinucleotide:
bc = basecount(HC22)
dimercount(HC22)
% GC-content:
(bc.G+bc.C)/(bc.A+bc.G+bc.T+bc.C)

%% Question 2
orfs = seqshoworfs(HC22(1:50000),'minimumlength',150);
% => 9
orfs = seqshoworfs(seqreverse(HC22(1:50000)),'minimumlength',150);
% => 6

%% Question 3
cpgi = cpgisland(HC22,'MinIsland', 200)
[val, ind] = max(cpgi.Stops-cpgi.Starts)
cpgi.Starts(13)
cpgi.Stops(13)
