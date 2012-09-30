function [initial_new, transition_new, emission_new] = BaumWelch_i( alphas, betas, initial, transition, emission, sequence, norm )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    L=length(sequence);
    N=length(initial);
    A=zeros(L,N);
    E=zeros(L,N,N);
    emit_l=length(emission(1,:));
    
    transition_new=zeros(N);
    emission_new = zeros(N, emit_l);
    
    for i=1:N
        for j=1:N
            for l=1:L-1
                E(l,i,j)=alphas(l,i)*transition(i,j)*emission(j,sequence(l+1))*betas(l+1,j)/norm(l+1);
            end
        end
    end
    
    for i=1:N
        for l=1:L
            A(l,i)=alphas(l,i)*betas(l,i);
        end
    end
    initial_new = A(1,:);
    
    for i=1:N
        for j=1:N
            transition_new(i,j)=sum(E(1:L-1,i,j))/(sum(A(1:L-1,i)));
        end
    end
    
    for j=1:N
        for b=1:emit_l
            times=find(sequence==b);
            emission_new(j,b)=sum(A(times,j))/sum(A(:,j));
        end
    end
    
   
end

