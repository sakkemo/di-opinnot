function [ logprob ] = sequenceprob(data, model)
%SEQUENCEPROB Summary of this function goes here
%   Detailed explanation goes here
load(model)
seq_numeric = nt2int(data);
probability = initial_distribution(seq_numeric(1));
for i=2:length(data)
    probability = probability*transition_probabilities(seq_numeric(i-1),seq_numeric(i));
end
logprob = log(probability);
end

