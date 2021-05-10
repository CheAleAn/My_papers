nn=0;  %не важно
nom=0; %не важно
T=P+sumofkids; %не важно
Rangall=zeros(T,4+GenomeLength);
RangLM=zeros(T,4);
score=zeros(T,2);
for i=1:P %сбор детей и родителей вместе, родители
    score(i,1)=scoreparents(i,1);    
    score(i,2)=scoreparents(i,2);
end
for i=(P+1):T %сбор детей и родителей вместе,дети
    scoreparents(i,1)=scorekids(i-P,1);
    scoreparents(i,2)=scorekids(i-P,2);
    score(i,1)=scorekids(i-P,1);
    score(i,2)=scorekids(i-P,2);
    for alpha=1:GenomeLength
    population(i,alpha)=xoverKids(i-P,alpha);
    end
end
clear scorekids
clear xoverKids



        
      