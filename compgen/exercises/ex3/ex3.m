%states M1, D1, I1, M2, D2, I2, M3,D3, I3,End
% [M]atch [D]elete [I]nsert
%Initial probabilities

a_0=[0.8,0.2,0,0,0,0,0,0,0];

%transition probabilities
a=zeros(9,10);

a(1,3)=0.1;
a(1,4)=0.7;
a(1,5)=0.2;

a(4,6)=0.2;
a(4,7)=0.6;
a(4,8)=0.2;

a(7,9)=0.1;
a(7,10)=0.9;

a(3,3)=0.25;
a(3,4)=0.75;
a(6,6)=0.25;
a(6,7)=0.75;
a(9,9)=0.25;
a(9,10)=0.75;
a(2,4)=1;
a(5,7)=1;
a(8,10)=1;

%emission probabilities
e=zeros(7,4);

e([3,6,9],1:4)=0.25;
e(1,1)=0.1;
e(1,2)=0.2;
e(1,3)=0.2;
e(1,4)=0.5;
e(4,1)=0.6;
e(4,2)=0.1;
e(4,3)=0.1;
e(4,4)=0.2;
e(7,1)=0.3;
e(7,2)=0.2;
e(7,3)=0.1;
e(7,4)=0.4;
e([2,5,8],5)=1; %gap

a_h=cumsum(a,2);
e_h=cumsum(e,2);
a0_h=cumsum(a_0);

sequences=cell(10,1);
paths=cell(10,1);

for i=1:10
    state=0;
    seq=[];
    path=[];
    %sequence length
    seq_len=1;
    ran=rand(1);
    state=find(a0_h>ran,1,'first');
    path=[path, state];
    % 10 is the end state
    while state<10
        ran_e=rand(1);
        % add nucleotide to your sequence
        seq=[seq, find(e_h(state,:)>ran_e,1,'first')];
        ran=rand(1);
        % new state
        state=find(a_h(state,:)>ran,1,'first');
        path=[path, state];
    end
    sequences{i}=seq;
    paths{i}=path;
end

% max number of times that we stayed in each insertion state
max_i_3=0;
max_i_6=0;
max_i_9=0;

for i=1:10
    k=paths{i};
    insertion_1 = length(find(k==3));
    insertion_2 = length(find(k==6));
    insertion_3 = length(find(k==9));
    if(max_i_3<insertion_1)
        max_i_3=insertion_1;
    end
    if(max_i_3<insertion_2)
        max_i_3=insertion_2;
    end
    if(max_i_3<insertion_3)
        max_i_3=insertion_3;
    end
end

% msa length is the number of match states + max length of each insertion
% state
msa_length = max_i_9 + max_i_6 + max_i_3+3;
msa = zeros(10, msa_length);

for i=1:10
    path=paths{i};
    seq = sequences{i};
    % first match state
    k=find(path==1);
    if(k)
        msa(i,1)=seq(k);
    end
    % second match state
    k = find(path==4);
    if(k)
        msa(i,2+max_i_3)=seq(k); %insertions in between (max_i_3)
    end
    % third match state
    k = find(path==7);
    if(k)
        msa(i,3+max_i_6)=seq(k);
    end
    
    % first insertion state
    k = find(path==3);
    for j=1:length(k)
        msa(i,1+j)=seq(k(j));
    end
    % second
    k = find(path==6);
    for j=1:length(k)
        msa(i,2+max_i_3+j)=seq(k(j));
    end
    % third
    k = find(path==9);
    for j=1:length(k)
        msa(i,3+max_i_3+max_i_6+j)=seq(k(j));
    end
end

msa_nt=int2nt(msa,'unknown','-');


%%
% _______
% |     |
% |     |
% |     |
% |_____|

cftr = getgenpept('NP_000483', 'SequenceOnly','true');
proteinplot(cftr)

%%

initial = [0 1];
transition = [.95 .05; .05 .95];
emission = [0.08*ones(1,10),0.0425, 0.0175*ones(1,9);
    0.015*ones(1,10),0.04, 0.09*ones(1,9)];
cftr_num=aa2int(cftr);

limit=0.001;
diff=200;
[alphas, norm, prob] = forward(initial, transition, emission, cftr_num);
likelihood_old=prob;

while abs(diff)>limit
    [betas] = backward(initial, transition, emission, cftr_num, norm);
    [initial, transition, emission] = BaumWelch_i(alphas, betas, initial, transition, emission, cftr_num, norm);
    [alphas, norm, prob] = forward(initial, transition, emission, cftr_num);
    likelihood_new=prob;
    diff=likelihood_old-likelihood_new;
    likelihood_old=likelihood_new;
end

clear('diff')
%% EX 3 Start
prob_all = zeros(1000,1);
prs = zeros(1000, 500);
for i = 1:1000
    prs(i,:) = hmmgenerate(500,transition, emission);
    [alphas, norm, prob] = forward(initial, transition, emission, prs(i,:));
    prob_all(i)=prob;
end
figure(1)
set(gcf,'units','centimeters');
set(gcf,'DefaultAxesFontSize',6)
set(gcf,'DefaultTextFontSize',6)
set(gcf,'DefaultLineLineWidth',2)
hist(prob_all)
title('Histogram of log probabilities for sequences')
ylabel('Frequency')
xlabel('Log probability of the sequence')

set(gcf,'paperunits',get(gcf,'units')) 
set(gcf,'paperpos',[0 0 6 6])
set(gcf,'papersize',[6 6])
print -dpdf fig_ex31seqlogprob 
proteinplot(int2aa(prs(1,:)));
figure(2)
set(gcf,'units','centimeters');
set(gcf,'DefaultAxesFontSize',6)
set(gcf,'DefaultTextFontSize',6)
set(gcf,'DefaultLineLineWidth',1)

plot(pp_data.Data)
title('Hydrophobicity of the first sequence (Black & Mould)')
ylabel('Hydrophobicity')
xlabel('Amino Acid')

set(gcf,'paperunits',get(gcf,'units')) 
set(gcf,'paperpos',[0 0 8 6])
set(gcf,'papersize',[8 6])
print -dpdf fig_ex31seqhydro


%% 2
n_transmembranic = zeros(100,1);
for i = 1:1000
    states = hmmviterbi(prs(i,:), transition, emission);
    tsig = states-1;
    dsig = diff(logical([1 tsig 1]));
    startIndex = find(dsig < 0);
    endIndex = find(dsig > 0)-1;
    duration = endIndex-startIndex+1;
    n_transmembranic(i) = length(duration);
end
figure(1)
set(gcf,'units','centimeters');
set(gcf,'DefaultAxesFontSize',6)
set(gcf,'DefaultTextFontSize',6)
set(gcf,'DefaultLineLineWidth',2)

hist(n_transmembranic, 1:6)

title('Histogram of number of transmembranic parts')
ylabel('Frequency')
xlabel('Number of transmembranic parts in each protein')

set(gcf,'paperunits',get(gcf,'units')) 
set(gcf,'paperpos',[0 0 6 6])
set(gcf,'papersize',[6 6])
print -dpdf fig_ex32

%% 3
CFTR = getgenpept('NP_000483', 'SequenceOnly','true');
hmm_CFTR = gethmmprof('PF14396');
seqs = gethmmalignment('PF14396', 'type', 'seed');
disp([char(seqs.Header) char(seqs.Sequence)]);
Score = hmmprofalign(hmm_CFTR, CFTR);
