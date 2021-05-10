clear all
tic;
Loaddata();
Variables();
%�������� ������
%���������
P=100; %���������
timelimit=600; %������ �� �������
cyclelimit=200; %������ �� ���-�� ������
repeatlimit=20;
Kurs=ceil(P/10);
lyam(1,1)=0.5;
lyam(1,2)=1-lyam(1,1);
thetta=1;

numberofcycle=0
CreationFcn(); %�������� ������ ���������

scoreparents=zeros(P,2);

for i=1:P %����� ��� ���������
    parents=population(i,:);
    Fitnesslife();
    scoreparents(i,1)=reghim(1);
    scoreparents(i,2)=reghim(2);
end

Rangparents(); %������������ ���������
method();%����� ������ ������
Rangparentspart2();%��������� ������������ ���������

repeatnow=0;
sumofkids=P;
scorekids=zeros(sumofkids,2);
xoverKids=zeros(sumofkids,GenomeLength);

%��
while numberofcycle<cyclelimit & repeatnow<repeatlimit %������� ���������
    numberofcycle=round(numberofcycle+1)
for i=1:P %��� ��������� ����� � ����������� �����
        Rang2(i,1)=Rangall(i,2);
        Rang2(i,2)=scoreparents(i,1);
        Rang2(i,3)=scoreparents(i,2);
end
%numberofcycle=numberofcycle+0.1
    Crossing();%�����������
    Mutation();%�������    
%numberofcycle=numberofcycle+0.1
for iii=1:sumofkids %������ ������ ��� �����
    parents=xoverKids(iii,:);
    Fitnesslife();
    scorekids(iii,1)=reghim(1);
    scorekids(iii,2)=reghim(2);
end
%numberofcycle=numberofcycle+0.1
Rangingall(); %������������ ��������� � �����
method();%����� ������ ������;
Rangingallpart2();%��������� ������������ ��������� � �����
%numberofcycle=numberofcycle+0.1
Comparison(); %��������� ����� � ����������� �����
end

for i=1:P %����� ������ ������� �����������
    if Rangall(i,2)<=Kurs
        scorenorm(i,1)=Rangall(i,3);
        scorenorm(i,2)=Rangall(i,4);
    end
end  
for i=1:P %����� ������ ������ �����������
    if Rangall(i,2)==1
        scorebest(i,1)=Rangall(i,3);
        scorebest(i,2)=Rangall(i,4);
    end
end 
scorebest
%�������
%plot(scoreparents(:,1),scoreparents(:,2),'w-',scoreparents(:,1),scoreparents(:,2),'ko');
%figure
%plot(scorebest(:,1),scorebest(:,2),'w-',scorebest(:,1),scorebest(:,2),'ko');
%figure
%plot(scorenorm(:,1),scorenorm(:,2),'w-',scorenorm(:,1),scorenorm(:,2),'ko');
time=toc
numberofcycle
X=Rangall(1:length(scorenorm),:)









