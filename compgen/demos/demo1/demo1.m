HBB = getgenbank('NM_000518.4','SequenceOnly', true);
bc = basecount(HBB, 'chart','pie');

HBB_fasta = fastaread('sequence.fasta');
HBB_fasta.Header
HBB_fasta.Sequence

ntdensity(HBB)
dimercount(HBB,'chart','bar')
orfs = seqshoworfs(HBB);
seq = HBB(orfs(3).Start:orfs(3).Stop);
nt2aa(seq)
nt2int(seq)

%% 1st order Markov model based on HBB
initial_distribution = zeros(4,1);
freq_init = basecount(HBB);
fields = fieldnames(freq_init);
for i=1:4
    initial_distribution(i)=getfield(freq_init,fields{i});
end
initial_distribution/sum(initial_distribution);


transition_probabilities = zeros(4);
freq_trans = dimercount(HBB);
fields_t = fieldnames(freq_trans);
for i=1:16
    transition_probabilities(i)=getfield(freq_trans,fields_t{i});
end
for i=1:4
    transition_probabilities(i,:) = transition_probabilities(i,:)/sum(transition_probabilities(i,:));
end
save('MM_HBB', 'initial_distribution', 'transition_probabilities');

%%
sequenceprob('CGCGCGCG', 'MM_HBB')
sequenceprob('ATATATAT', 'MM_HBB')
