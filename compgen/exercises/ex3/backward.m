function [ betas ] = backward(initial, transition, emission, sequence, norm_factor)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    L=length(sequence);
    N=length(initial);
    betas=ones(L,N);
    
    for l=L-1:-1:1
        for j=1:N
            betas(l,j)=sum(betas(l+1,:)'.*transition(j,:)'.*(emission(:,sequence(l+1))))/norm_factor(l+1);
        end
    end
    


end

