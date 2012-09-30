function [alphas, norm_factor, prob_log] = forward( initial, transition, emission, sequence )
%FORWARD Summary of this function goes here
%   Detailed explanation goes here
    L=length(sequence);
    N=length(initial);
    alphas=zeros(L,N);
    norm_factor=zeros(L,1);
    
    % initialization step
    for i=1:N
        alphas(1,i)=initial(i)*emission(1, sequence(1));
    end
    norm_factor(1) = sum(alphas(1,:),2);
    alphas(1,:) = alphas(1,:)/norm_factor(1);

    % recursion step
    for l=1:L-1
        for j=1:N
            alphas(l+1,j)=sum(alphas(l,:).*transition(j,:)).*emission(j,sequence(l+1));
        end
        norm_factor(l+1)=sum(alphas(l+1,:),2);
        alphas(l+1,:) = alphas(l+1,:)/norm_factor(l+1);

    end
    
    %termination
    prob_log = sum(log(norm_factor));
end

