%% Exercise set 3
 
edges1 = importdata('../ex2/Becs-114_4150_karate_club_network__edge_file.edg');
links1 = length(edges1);
 
% find largest value, N
N1 = max(max(edges1));
 
A1 = zeros(N1,N1);
 
for i=1:length(edges1),
node1 = edges1(i,1);
node2 = edges1(i,2);
A1(node1,node2) = 1;
A1(node2,node1) = 1;
end
 
%% eigenvector centrality
% columns are eigenvectors in eig_vector
[eig_vector,eig_value] = eig(A1);
eig_values = diag(eig_value);
 
% the eigenvector centrality of a node equals the value of the
% corresponding element in the eigenvector related to the largest
% eigenvalue of the adjacency matrix
 
% eig values automatically re-organized:
% centrality:
C = abs(eig_vector(:,end));
 
% the iterative method
x = ones(N1,1);
for i=1:1000,
x = A1*x;
x = normc(x); % normalize
end
 
% note that x and C are the same!
 
% a) Which of the nodes has the largest eigenvector centrality and what is this value?
[max_C, max_value_idx] = max(C)
 
%% b)
% Compute the degree of each node, and plot the eigenvector centralities
% of all nodes against their degree in a scatter plot.
% How does the eigenvector centrality depend on degree?
degree = sum(A1);
 
% scatterplot
figure(1)
plot(degree,C,'x','MarkerSize',12,'LineWidth',2)
xlabel('degree','FontSize',16)
ylabel('eigenvector centrality','FontSize',16)
set(gca,'FontSize',12)
 
%% 2 b) k-shell indices
A = [ 0 1 1 1 0;
      1 0 1 1 0;
      1 1 0 1 0;
      1 1 1 0 1;
      0 0 0 1 0;]
% A = A1;
k = sum(A,1);
shell_index = 1;
N = size(A,1);
shell_indices = zeros(N,1);
while (sum(sum(A))~=0),
    % find nodes still in graph
    remaining_nodes = find(shell_indices==0);
    % their remaining degrees (note that size of k does not change!)
    k = sum(A,1);
    remaining_degrees = k(remaining_nodes);
    while any(find(remaining_degrees<=shell_index)),
        % logical vector: remove if TRUE
        remove_us = find(sum(A,1)<=shell_index & (shell_indices==0)');
        shell_indices(remove_us) = shell_index;
        % removes all links of node remove_us
        A(remove_us,:)=0; A(:,remove_us)=0;
        % check in any other listed node has zero degree
        if any(find(remaining_degrees==0)),
            remove = find(sum(A,1)==0 & (shell_indices==0)');
            shell_indices(remove) = shell_index;
            A(remove,:)=0; A(:,remove)=0;
            disp('remove these singles')
            disp(remove)
        end
        % compute degrees again
        remaining_nodes = find(shell_indices==0);
        k = sum(A,1);
        remaining_degrees = k(remaining_nodes);
        disp('remove these low-order nodes')
        disp(remove_us)
    end
    % new shell index
    shell_index = shell_index + 1;
    disp(sum(sum(A)))
end