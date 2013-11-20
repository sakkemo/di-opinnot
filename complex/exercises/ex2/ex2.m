
%% a) Average degree of networks
dolphins = load('Becs-114_4150_dolphin_network__edge_file.edg');
N_dolphins = max(max(dolphins));
A = zeros(N_dolphins);

for i=1:length(dolphins)
    A(dolphins(i,1),dolphins(i,2))=1;
    A(dolphins(i,2),dolphins(i,1))=1;
end
% Average degree:
average_degree_dolphins = mean(sum(A))
A_dolphins = A;

karate = load('Becs-114_4150_karate_club_network__edge_file.edg');
N_karate = max(max(karate));
A = zeros(N_karate);

for i=1:length(karate)
    A(karate(i,1),karate(i,2))=1;
    A(karate(i,2),karate(i,1))=1;
end
% Average degree:
average_degree_karate = mean(sum(A))
A_karate = A;

%% b) Edge density:
edge_density_dolphins = 2*length(dolphins)/N_dolphins/(N_dolphins-1)
edge_density_karate = 2*length(karate)/N_karate/(N_karate-1)

%% c) Average clustering coefficients:
k = sum(A_dolphins,2);
k_dolphins = k;
average_clustering_dolphins = mean(0.5*diag(A_dolphins^3)./(1/2*k.*(k-1)+eps))

k = sum(A_karate,2);
k_karate = k;
average_clustering_karate = mean(0.5*diag(A_karate^3)./(1/2*k.*(k-1)+eps))

%% d) Erdös-Renyi equivalent clustering coefficients:
p_dolphins = length(dolphins)/N_dolphins/(N_dolphins-1)
p_karate = length(karate)/N_karate/(N_karate-1)

average_clustering_random_dolphins = edge_density_dolphins*(N_dolphins-1)
average_clustering_random_karate = edge_density_karate*(N_karate-1)

%% e) Cumulative degree distribution
clear('distr')
for i=1:max(k_dolphins)
    distr(i) = length(find(k_dolphins>i))/length(k_dolphins);
end
plot(distr)
for i=1:max(k_karate)
    distr(i) = length(find(k_karate>i))/length(k_karate);
end
%% karate
plot(distr)
