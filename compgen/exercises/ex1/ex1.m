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

%% Question 4
% 2nd order Markov model based on HBB
initial_distribution = zeros(16,1);
freq_init = dimercount(HC22);
fields = fieldnames(freq_init);
for i=1:16
    initial_distribution(i)=getfield(freq_init,fields{i});
end
initial_distribution = initial_distribution/sum(initial_distribution);


transition_probabilities = zeros(4,16);
[freq_trans, carray] = codoncount(HC22);
fields_t = fieldnames(freq_trans);
for i=1:64
    transition_probabilities(i)=getfield(freq_trans,fields_t{i});
end
transition_probabilities=transition_probabilities';
% now we have a transition matrix
%     A   C   G   T
% AA
% AC
% AG
% AT
for i=1:16
    transition_probabilities(i,:) = transition_probabilities(i,:)/sum(transition_probabilities(i,:));
end

seq_numeric = nt2int('gatacc');
probability = initial_distribution((seq_numeric(1)-1)*4+seq_numeric(2));
for i=3:length(seq_numeric)
    probability = probability*transition_probabilities((seq_numeric(i-2)-1)*4+seq_numeric(i-1),seq_numeric(i));
end
logprob = log(probability);

% for j=1:16
% seq_numeric = nt2int(char(fields_t(j)));
% probability = initial_distribution((seq_numeric(1)-1)*4+seq_numeric(2));
% for i=3:length(seq_numeric)
%     probability = probability*transition_probabilities((seq_numeric(i-2)-1)*4+seq_numeric(i-1),seq_numeric(i));
% end
% logprob = log(probability);
% fprintf('%d %f\n', getfield(freq_trans,fields_t{j}), logprob)
% end
