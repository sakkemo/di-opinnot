%% Exercise set 4
 
% load data
edges = importdata('Becs-114_4150_sms_network__edge_file.edg');
E = length(edges);
 
%% find largest value, N
N = max(max(edges(:,[1 2])));
 
%% allocate memory
W = spalloc(N,N,2*E);
A = spalloc(N,N,2*E);
 
for i=1:length(edges),
node1 = edges(i,1)+1;
node2 = edges(i,2)+1;
weight = edges(i,3);
W(node1,node2) = weight;
W(node2,node1) = weight;
A(node1,node2) = 1;
A(node2,node1) = 1;
end
% local degrees
k = sum(A,2);
% strengths
s = sum(W,2);
 
%% cumulative weight and strength distributions
L = 500;
cum_strength = zeros(1,L);
for i=1:L,
cum_strength(i) = length(find(s>i))/length(s);
end
printsetup()
plot(cum_strength);title('Cumulative strength of nodes');xlabel('s');
printfig('pdf', 'str.pdf')
%% weights
w = W(:);
K = 100;
cum_weights = zeros(1,K);
for i=1:L,
cum_weights(i) = length(find(w>i));
end
printsetup()
plot(cum_weights);title('Cumulative weight distribution');xlabel('w');
printfig('pdf', 'wts.pdf')
%% average strengths of each degree
L = 50;
average_strength = zeros(L,1);
for i=1:L,
% find indices
[j,~] = find(k==i);
ss = s(j);
if any(ss)
average_strength(i) = sum(ss)/numel(ss);
else
average_strength(i) = 0;
end
end
% remove zeros
zero = find(average_strength==0);
average_strength(zero) = [];
xx = 1:L;
xx(zero) = [];
% double log scale
xx = log(xx);
yy = log(average_strength);
B = polyfit(xx',yy,1);
yy_est = B(1)*xx.^1+ B(2)*xx.^0;
 
printsetup()
plot(xx,yy);title('Average log-strength of each log-degree');xlabel('log-k');ylabel('log-<s(k)>')
hold on
plot(xx,yy_est,'r--')
legend('strength',sprintf('OLS solution: beta = %02.2f',B(1)));
printfig('pdf', 'loglog.pdf') 

%% Overlap
O = zeros(1,E);
W = zeros(1,E);
bros = A^2;
degrees = sum(A,1);
binsize=50;
for i=1:E
    ith = edges(i,1)+1;
    jth = edges(i,2)+1;
    O(i) = bros(ith, jth)/(degrees(ith)+degrees(jth)-2-bros(ith,jth));
    W(i) = round(edges(i,3)/binsize)*binsize;
end

Osorted = zeros(1,length(unique(W)));
Wsorted = zeros(1,length(unique(W)));
i=1;
for val=sort(unique(W))
    Osorted(i) = nanmean(O(W==val));
    Wsorted(i) = val;
    i=i+1;
end

printsetup()
scatter(Wsorted(1:end-5),Osorted(1:end-5))
printfig('pdf', 'overlap.pdf')
