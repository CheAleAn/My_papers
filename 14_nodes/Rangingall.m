nn=0;  %�� �����
nom=0; %�� �����
T=P+sumofkids; %�� �����
Rangall=zeros(T,4+GenomeLength);
RangLM=zeros(T,4);
score=zeros(T,2);
for i=1:P %���� ����� � ��������� ������, ��������
    score(i,1)=scoreparents(i,1);    
    score(i,2)=scoreparents(i,2);
end
for i=(P+1):T %���� ����� � ��������� ������,����
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



        
      